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

		require("keymaps.leap")

		leap.opts.preview = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
		end

		leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

		require("leap.user").set_repeat_keys("<Leader><enter>", "<Leader><backspace>")
	end,
}
