local colors = {
	black = "#000000",
	white = "#ffffff",

	-- NOTE: background colors
	bg0 = "#f7f7f7",
	bg1 = "#b7b7b7",
	bg2 = "#5b5b5b",
	bg3 = "#2b2b2b",
	bg4 = "#e0e0e0",

	-- NOTE: old colors
	-- blue = "#325CC0",
	-- green = "#387520",
	-- red = "#AA3731",
	-- magenta = "#7A3E9D",
	-- orange = "#FFBC5D",
	orangeBright = "#dd8100",

	-- NOTE: light colors
	redLight = "#f5d2d5",
	redLight2 = "#fae8ea",
	greenLight = "#d1e5d7",
	greenLight2 = "#e8f2eb",
	blueLight = "#cde1f7",
	blueLight2 = "#e6f0fb",
	magentaLight = "#e6dcf8",
	magentaLight2 = "#f2edfb",
	orangeLight = "#f8e5cc",
	orangeLight2 = "#fbf2e5",
	fgLight = "#d2d3d4",
	fgLight2 = "#e8e9e9",
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local palette = require("github-theme.palette.github_light_default").palette
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
						b = { bg = colors.fgLight2, fg = colors.black },
						c = { bg = colors.fgLight2, fg = colors.black },
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
