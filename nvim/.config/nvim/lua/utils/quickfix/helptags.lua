local M = {}

M.to_qflist = function()
	local langs = vim.split(vim.o.helplang, ",", { trimempty = true })
	if not vim.tbl_contains(langs, "en") then
		table.insert(langs, "en")
	end

	local langs_map = {}
	for _, lang in ipairs(langs) do
		langs_map[lang] = true
	end

	local tag_files = {}
	local function add_tag_file(lang, file)
		if langs_map[lang] then
			if tag_files[lang] then
				table.insert(tag_files[lang], file)
			else
				tag_files[lang] = { file }
			end
		end
	end

	local help_files = {}

	-- Get runtime path, including lazy.nvim unloaded plugins
	local rtp = vim.o.runtimepath
	local lazy = package.loaded["lazy.core.util"]
	if lazy and lazy.get_unloaded_rtp then
		local paths = lazy.get_unloaded_rtp("")
		if #paths > 0 then
			rtp = rtp .. "," .. table.concat(paths, ",")
		end
	end

	local all_files = vim.fn.globpath(rtp, "doc/*", 1, 1)
	for _, fullpath in ipairs(all_files) do
		local file = vim.fn.fnamemodify(fullpath, ":t")
		if file == "tags" then
			add_tag_file("en", fullpath)
		elseif file:match("^tags%-..$") then
			local lang = file:sub(-2)
			add_tag_file(lang, fullpath)
		else
			help_files[file] = fullpath
		end
	end

	-- First pass: collect all tags grouped by file
	local tags_by_file = {}
	local delimiter = string.char(9) -- tab character

	for _, lang in ipairs(langs) do
		for _, tagfile in ipairs(tag_files[lang] or {}) do
			local ok, lines = pcall(vim.fn.readfile, tagfile)
			if ok then
				for _, line in ipairs(lines) do
					if not line:match("^!_TAG_") then
						local fields = vim.split(line, delimiter, { plain = true })
						if #fields >= 3 then
							local tag_name = fields[1]
							local doc_file = fields[2]
							local tag_address = fields[3]

							if not (tag_name == "help-tags" and doc_file == "tags") then
								local full_path = help_files[doc_file]
								if full_path then
									local pattern = tag_address
									if pattern:sub(1, 1) == "/" or pattern:sub(1, 1) == "?" then
										pattern = pattern:sub(2)
									end

									if not tags_by_file[full_path] then
										tags_by_file[full_path] = {}
									end
									table.insert(tags_by_file[full_path], {
										tag_name = tag_name,
										pattern = pattern,
									})
								end
							end
						end
					end
				end
			end
		end
	end

	-- Second pass: read each file once and find line numbers for all its tags
	print("Loading help tags...")
	local qf_items = {}

	for full_path, tags in pairs(tags_by_file) do
		local ok, file_lines = pcall(vim.fn.readfile, full_path)
		if ok then
			for _, tag_info in ipairs(tags) do
				local lnum = 0
				for line_idx, line_content in ipairs(file_lines) do
					if line_content:find(tag_info.pattern, 1, true) then
						lnum = line_idx
						break
					end
				end
				table.insert(qf_items, {
					filename = full_path,
					lnum = lnum > 0 and lnum or 1,
					text = tag_info.tag_name,
				})
			end
		end
	end

	vim.fn.setqflist({}, " ", { items = qf_items, title = "Help Tags" })
	vim.cmd("bot copen")

	print(string.format("Added %d help tags to quickfix list", #qf_items))
end

return M
