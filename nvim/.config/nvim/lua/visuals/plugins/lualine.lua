return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = require("colors")
		local palette = colors.palette
		-- vim.print(palette)

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = {
					normal = {
						a = { bg = palette.fg.default, fg = colors.white, gui = "bold" },
						b = { bg = colors.fgLight2, fg = colors.black },
						c = { bg = colors.fgLight2, fg = colors.black },
					},
					insert = {
						a = { bg = palette.blue.base, fg = colors.white, gui = "bold" },
						b = { bg = colors.blueLight, fg = colors.black },
						c = { bg = colors.blueLight, fg = colors.black },
					},
					visual = {
						a = { bg = palette.magenta.base, fg = colors.white, gui = "bold" },
						b = { bg = colors.magentaLight, fg = colors.black },
						c = { bg = colors.magentaLight, fg = colors.black },
					},
					replace = {
						a = { bg = colors.orangeBright, fg = colors.white, gui = "bold" },
						b = { bg = colors.orangeLight, fg = colors.black },
						c = { bg = colors.orangeLight, fg = colors.black },
					},
					command = {
						a = { bg = palette.green.bright, fg = colors.white, gui = "bold" },
						b = { bg = colors.greenLight, fg = colors.black },
						c = { bg = colors.greenLight, fg = colors.black },
					},
					terminal = {
						a = { bg = palette.red.base, fg = colors.white, gui = "bold" },
						b = { bg = colors.redLight, fg = colors.black },
						c = { bg = colors.redLight, fg = colors.black },
					},
					inactive = {
						a = { bg = colors.bg1, fg = colors.white, gui = "bold" },
						b = { bg = colors.bg4, fg = colors.black },
						c = { bg = colors.bg4, fg = colors.black },
					},
				},
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics", "filename" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "encoding", "filetype", "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
		-- Show divider between horizontal splits
		vim.opt.laststatus = 3
	end,
}
