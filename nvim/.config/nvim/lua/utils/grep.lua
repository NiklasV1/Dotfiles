local M = {}

M.run_grep = function(query, case_sensitive, files, tag)
	if not query or query == "" then
		print("No query provided.")
		return
	end

	vim.cmd("stopinsert")

	-- Parts of the ripgrep command
	local parts = { "rg", "-H", "--no-heading", "--vimgrep", "--follow" }
	local tag_text = ""

	if tag and tag ~= "" then
		tag_text = string.format(" [%s]", tag)
	end

	if case_sensitive then
		table.insert(parts, "--case-sensitive")
	else
		table.insert(parts, "--smart-case")
	end

	table.insert(parts, vim.fn.shellescape(query))

	if files and #files > 0 then
		table.insert(parts, table.concat(files, " "))
	end

	local cmd = table.concat(parts, " ")

	local results = vim.fn.systemlist(cmd)
	local title = string.format("Search: %s%s", query, tag_text)

	vim.fn.setqflist({}, " ", { title = title, lines = results })
	vim.cmd("bot copen")
end

return M
