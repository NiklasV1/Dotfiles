return {
	name = "leap",
	url = "https://codeberg.org/andyg/leap.nvim.git",
	enabled = true,
	lazy = false,
	config = function(_, opts)
		local leap = require("leap")
		for k, v in pairs(opts) do
			leap.opts[k] = v
		end

		vim.keymap.set({ "n", "x", "o" }, "<Leader>f", "<Plug>(leap)", { desc = "[f]ind" })
		vim.keymap.set("n", "<Leader>F", "<Plug>(leap-from-window)", { desc = "[F]ind from window" })

		-- Highly recommended: define a preview filter to reduce visual noise
		-- and the blinking effect after the first keypress (see
		-- `:h leap.opts.preview`).
		-- For example, skip preview if the first character of the match is
		-- whitespace or is in the middle of an alphabetic word:
		leap.opts.preview = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
		end

		-- Define equivalence classes for brackets and quotes, in addition to
		-- the default whitespace group:
		leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

		-- Use the traversal keys to repeat the previous motion without
		-- explicitly invoking Leap:
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")
	end,
}
