local fallbackNodeVersion = vim.env.HOME .. "/.nvm/versions/node/v22.14.0"
local nodePath = vim.fn.glob(vim.env.HOME .. "/.nvm/versions/node/v22.*", true, true)[1] or fallbackNodeVersion

local languageServerPath = nodePath .. "/lib/node_modules/@angular/language-server/bin/ngserver"
local typescriptPath = nodePath .. "/lib/node_modules/typescript/lib"
local angularLanguageServicePath = nodePath .. "/lib/node_modules/@angular/language-service"

local angularls_new_cmd = {
	languageServerPath,
	"--stdio",
	"--tsProbeLocations",
	typescriptPath,
	"--ngProbeLocations",
	angularLanguageServicePath,
	"--forceStrictTemplates",
}

local function findAngularRootDir(bufnr, on_dir)
	local filename = vim.api.nvim_buf_get_name(bufnr)

	-- Return without calling on_dir to prevent attaching to backend files
	if require("utils.lsp-utils").is_backend_dir(filename) then
		return
	end

	local root_files = {
		"angular.json",
		"nx.json",
		".git",
	}
	on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = filename, upward = true })[1]))
end

---@type vim.lsp.Config
return {
	cmd = angularls_new_cmd,
	filetypes = { "typescript", "html", "htmlangular", "htmldjango" },
	root_dir = findAngularRootDir,
	on_new_config = function(new_config, _)
		new_config.cmd = angularls_new_cmd
	end,
}
