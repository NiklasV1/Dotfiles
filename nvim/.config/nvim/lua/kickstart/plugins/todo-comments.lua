-- Add highlighted keywords to comments
-- Examples:
-- FIX: test
-- TODO: test
-- HACK: test
-- WARN: test
-- PERF: test
-- NOTE: test
-- TEST: test

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
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},

			colors = {
				info = { "#387520" },
				hint = { "#325CC0" },
				error = { "#AA3731" },
				optimize = { "#7A3E9D" },
				warning = { "#FFBC5D" },
				test = { "#000000" },
			},
		},
	},
}

-- vim: ts=2 sts=2 sw=2 et
