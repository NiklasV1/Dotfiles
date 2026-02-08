local function is_backend_dir(filename)
	if string.match(filename, "snapaddy%-backend") then
		return true
	end

	return false
end

local function filterDuplicates(array)
	local uniqueArray = {}
	for _, tableA in ipairs(array) do
		local isDuplicate = false
		for _, tableB in ipairs(uniqueArray) do
			if vim.deep_equal(tableA, tableB) then
				isDuplicate = true
				break
			end
		end
		if not isDuplicate then
			table.insert(uniqueArray, tableA)
		end
	end
	return uniqueArray
end

local function on_list_filtered(options)
	options.items = filterDuplicates(options.items)
	vim.fn.setqflist({}, " ", options)
	vim.cmd("bot copen")
end

local function lsp_references_deduplicated()
	vim.lsp.buf.references(nil, { on_list = on_list_filtered })
end

return {
	is_backend_dir = is_backend_dir,
	lsp_references_deduplicated = lsp_references_deduplicated,
}
