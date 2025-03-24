return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#e0e0e0" })
		vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "#e0e0e0" })
		require("treesitter-context").setup({})
	end,
}
