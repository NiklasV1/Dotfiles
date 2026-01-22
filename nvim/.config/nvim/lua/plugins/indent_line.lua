return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
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
			vim.api.nvim_set_hl(0, "IndentLineScope", { fg = "#0969da" })
			require("ibl").setup(opts)
		end,
	},
}
