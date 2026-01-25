---@type vim.lsp.Config
return {
	init_options = {
		hostInfo = "neovim",
		preferences = {
			importModuleSpecifierPreference = "relative",
			importModuleSpecifierEnding = "minimal",
		},
	},
}
