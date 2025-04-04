return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local colors = require("colors")

		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = colors.white })
		vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = colors.white })
		vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = colors.redLight2 })
		vim.api.nvim_set_hl(
			0,
			"TreesitterContextLineNumberBottom",
			{ bg = colors.palette.red.bright, fg = colors.white, bold = true }
		)
		require("treesitter-context").setup({})
	end,
}
