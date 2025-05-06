-- Add highlighted keywords to comments
-- Examples:
-- FIX: test
-- TODO: test
-- HACK: test
-- WARN: test
-- PERF: test
-- NOTE: test
-- TEST: test
-- DEPRECATED: test
-- SECTION: test

return {
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", color = "optimize", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				-- TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				DEPRECATED = { icon = " ", color = "error", alt = {} },
				SECTION = { color = "section", alt = {} },
			},
			gui_style = {
				fg = "BOLD", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			colors = {
				info = { "#387520" },
				hint = { "#325CC0" },
				error = { "#d1242f" },
				optimize = { "#7A3E9D" },
				warning = { "#FFBC5D" },
				section = { "#AA3731" },
				-- test = { "#000000" },
			},
		},
	},
}

-- vim: ts=2 sts=2 sw=2 et
