local function findTailwindRootDir(bufnr, on_dir)
	local filename = vim.api.nvim_buf_get_name(bufnr)

	-- Return without calling on_dir to prevent attaching to backend files
	if require("utils.lsp-utils").is_backend_dir(filename) then
		return
	end

	local root_files = {
		-- Fallback for tailwind v4, where tailwind.config.* is not required anymore
		".git",
		-- Generic
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
		"postcss.config.js",
		"postcss.config.cjs",
		"postcss.config.mjs",
		"postcss.config.ts",
	}
	on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = filename, upward = true })[1]))
end

---@type vim.lsp.Config
return {
	filetypes = { "html", "htmlangular", "htmldjango" },
	root_dir = findTailwindRootDir,
}
