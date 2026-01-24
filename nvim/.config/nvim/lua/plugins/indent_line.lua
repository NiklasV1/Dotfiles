return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
			highlight = {
				"IndentLineDefault",
			},
		},
		scope = {
			enabled = true,
			highlight = {
				"IndentLineScope",
			},
		},
	},
	config = function(_, opts)
		vim.api.nvim_set_hl(0, "IndentLineDefault", { fg = "#d2d3d4" })
		vim.api.nvim_set_hl(0, "IndentLineScope", { fg = "#b8bb26" })
		require("ibl").setup(opts)
	end,
}
