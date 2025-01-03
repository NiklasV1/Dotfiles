local colors = {
	black = "#000000",
	white = "#ffffff",

	bg4 = "e0e0e0",

	bg0 = "#f7f7f7",
	bg1 = "#b7b7b7",
	bg2 = "#5b5b5b",
	bg3 = "#2b2b2b",

	blue = "#325CC0",
	green = "#387520",
	red = "#AA3731",
	magenta = "#7A3E9D",
	orange = "#FFBC5D",
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = {
					normal = {
						a = { bg = colors.bg3, fg = colors.white, gui = "bold" },
						b = { bg = colors.bg4, fg = colors.black },
						c = { bg = colors.bg4, fg = colors.black },
					},
					insert = {
						a = { bg = colors.blue, fg = colors.white, gui = "bold" },
						b = { bg = colors.bg0, fg = colors.black },
						c = { bg = colors.bg0, fg = colors.black },
					},
					visual = {
						a = { bg = colors.magenta, fg = colors.white, gui = "bold" },
						b = { bg = colors.bg0, fg = colors.black },
						c = { bg = colors.bg0, fg = colors.black },
					},
					replace = {
						a = { bg = colors.red, fg = colors.white, gui = "bold" },
						b = { bg = colors.bg0, fg = colors.black },
						c = { bg = colors.bg0, fg = colors.black },
					},
					command = {
						a = { bg = colors.green, fg = colors.white, gui = "bold" },
						b = { bg = colors.bg0, fg = colors.black },
						c = { bg = colors.bg0, fg = colors.black },
					},
					inactive = {
						a = { bg = colors.bg1, fg = colors.white, gui = "bold" },
						b = { bg = colors.bg0, fg = colors.black },
						c = { bg = colors.bg0, fg = colors.black },
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
	end,
}
