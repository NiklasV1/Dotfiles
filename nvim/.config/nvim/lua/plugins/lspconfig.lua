-- For configs see: https://github.com/neovim/nvim-lspconfig/tree/master/lsp

local tools = {
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
	"bashls",
	"pyright",
	"autopep8",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Debugging
		-- vim.lsp.set_log_level("debug")

		require("mason").setup()
		require("mason-lspconfig").setup()
		require("mason-tool-installer").setup({ ensure_installed = tools })
	end,
}
