return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		local colors = require("colors")
		-- Setup theme
		require("github-theme").setup({
			options = {
				darken = {
					floats = false,
					sidebars = {
						enable = false,
					},
				},
			},
			palettes = {
				all = {
					fg = {
						default = colors.black,
					},
					border = {
						default = colors.black,
					},
				},
			},
		})

		vim.cmd("colorscheme github_light_default")

		-- NOTE: Diagnostics
		vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.Error })
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.white, bg = colors.Error })

		vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.Warning })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.white, bg = colors.Warning })

		vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.Info })

		vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.Hint })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
		vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticHint" })

		-- NOTE: Gitsigns
		vim.api.nvim_set_hl(0, "Added", { fg = colors.black, bg = colors.greenLight })
		vim.api.nvim_set_hl(0, "Changed", { fg = colors.black, bg = colors.orangeLight })
		vim.api.nvim_set_hl(0, "Removed", { fg = colors.black, bg = colors.redLight })
		vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "Added" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { link = "Changed" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "Removed" })

		-- NOTE: Misc
		vim.api.nvim_set_hl(0, "@comment.todo", { fg = colors.black })
		vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.black, bg = "#ffd363" })
		-- vim.api.nvim_set_hl(0, "Comment", { fg = "#0b5c00" })
	end,
}
