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
			vim.api.nvim_set_hl(0, "IndentLineDefault", { fg = "#CECECE" })
			vim.api.nvim_set_hl(0, "IndentLineScope", { fg = "#325CC0" })
			require("ibl").setup(opts)
		end,
	},
}
