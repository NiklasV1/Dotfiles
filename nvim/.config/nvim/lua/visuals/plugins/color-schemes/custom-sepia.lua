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
					bg0 = colors.bg0,
					border = {
						default = colors.black,
					},
				},
			},
		})

		vim.cmd("colorscheme github_light_default")

		-- SECTION: Diagnostics
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
		vim.api.nvim_set_hl(0, "GitSignsAddInline", { fg = colors.black, bg = colors.greenLight3 })
		vim.api.nvim_set_hl(0, "GitSignsChange", { link = "Changed" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "Removed" })
		vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { fg = colors.black, bg = colors.redLight3 })

		-- NOTE: Misc
		vim.api.nvim_set_hl(0, "@comment.todo", { fg = colors.black })
		vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.black, bg = colors.yellow })
		-- vim.api.nvim_set_hl(0, "Comment", { fg = "#0b5c00" })

		-- SECTION: Syntax highlighting
		vim.api.nvim_set_hl(0, "Function", { fg = colors.Definition })
		vim.api.nvim_set_hl(0, "Method", { link = "Function" })
		vim.api.nvim_set_hl(0, "String", { fg = colors.Strings })
		vim.api.nvim_set_hl(0, "Constant", { fg = colors.Constants })
		vim.api.nvim_set_hl(0, "Number", { link = "Constant" })
		vim.api.nvim_set_hl(0, "Comment", { fg = colors.Comments })
		vim.api.nvim_set_hl(0, "Type", { fg = colors.black })
		vim.api.nvim_set_hl(0, "Operator", { fg = colors.black })
		vim.api.nvim_set_hl(0, "Keyword", { fg = colors.black })

		vim.api.nvim_set_hl(0, "@type", { link = "Type" })
		vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@constant.html", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
		vim.api.nvim_set_hl(0, "@attribute.typescript", { link = "Function" })
		vim.api.nvim_set_hl(0, "@variable.member", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
		vim.api.nvim_set_hl(0, "Tag", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@tag", { link = "Function" })
		vim.api.nvim_set_hl(0, "@keyword.angular", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@tag.attribute.angular", { link = "@keyword.angular" })
		vim.api.nvim_set_hl(0, "@markup.raw", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@markup.italic", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@markup.list.checked", { fg = colors.black, bg = colors.greenLight })
		vim.api.nvim_set_hl(0, "@markup.list.unchecked", { fg = colors.black, bg = colors.redLight })
		vim.api.nvim_set_hl(0, "@constant.go", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@lsp.type.regexp", { link = "String" })
		vim.api.nvim_set_hl(0, "@string.regexp", { link = "String" })
		vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
		vim.api.nvim_set_hl(0, "@function.builtin.lua", { link = "Function" })
		vim.api.nvim_set_hl(0, "@function.builtin.make", { link = "Function" })
		vim.api.nvim_set_hl(0, "@function.builtin.bash", { link = "Function" })
		vim.api.nvim_set_hl(0, "@keyword.exception", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@string.scss", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@number.scss", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@number.float.scss", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#555555" })
		-- vim.api.nvim_set_hl(0, "@spell.markdown", { link = "Comment" })

		-- NOTE: bg highlighting
		-- vim.api.nvim_set_hl(0, "Function", { bg = colors.blueLight, fg = colors.black })
		-- vim.api.nvim_set_hl(0, "Method", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "String", { bg = colors.greenLight, fg = colors.black })
		-- vim.api.nvim_set_hl(0, "Constant", { bg = colors.magentaLight, fg = colors.black })
		-- vim.api.nvim_set_hl(0, "Number", { link = "Constant" })
		-- vim.api.nvim_set_hl(0, "Comment", { fg = colors.Comments })
		-- vim.api.nvim_set_hl(0, "Type", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "Operator", { fg = colors.black })
		--
		-- vim.api.nvim_set_hl(0, "@type", { link = "Type" })
		-- vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })
		-- vim.api.nvim_set_hl(0, "@constant.html", { link = "Constant" })
		-- vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
		-- vim.api.nvim_set_hl(0, "@attribute.typescript", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@variable.member", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "Tag", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@tag", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@keyword.angular", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@tag.attribute.angular", { link = "@keyword.angular" })
		-- vim.api.nvim_set_hl(0, "@markup.raw", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@markup.italic", { link = "Keyword" })
		-- vim.api.nvim_set_hl(0, "@markup.list.checked", { fg = colors.black, bg = colors.greenLight })
		-- vim.api.nvim_set_hl(0, "@markup.list.unchecked", { fg = colors.black, bg = colors.redLight })
		-- vim.api.nvim_set_hl(0, "@constant.go", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@lsp.type.regexp", { link = "String" })
		-- vim.api.nvim_set_hl(0, "@string.regexp", { link = "String" })
		-- vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@function.builtin.lua", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@function.builtin.make", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@function.builtin.bash", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@keyword.exception", { link = "Keyword" })
		-- vim.api.nvim_set_hl(0, "@string.scss", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@number.scss", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@number.float.scss", { fg = colors.black })
		-- vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#555555" })
	end,
}
