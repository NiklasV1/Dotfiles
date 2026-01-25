-- For configs see: https://github.com/neovim/nvim-lspconfig/tree/master/lsp

local ensure_installed = {
	-- Lua
	"lua_ls",
	"stylua",

	-- Web dev
	"ts_ls",
	"html",
	"cssls",
	"angularls",
	"tailwindcss",
	"eslint",
	"prettierd",

	-- Misc
	"typos_lsp",
	"gopls",
	"pyright",
	"bashls",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
		})
	end,
}
