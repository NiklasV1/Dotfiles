return {
	"joeveiga/ng.nvim",
	config = function()
		local ng = require("ng")

		vim.keymap.set(
			"n",
			"<leader>at",
			ng.goto_template_for_component,
			{ desc = "[A]ngular [T]emplate", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>ac",
			ng.goto_component_with_template_file,
			{ desc = "[A]ngular [C]omponent", noremap = true, silent = true }
		)
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>ab",
		-- 	ng.get_template_tcb,
		-- 	{ desc = "[A]ngular TypeCheck[B]lock", noremap = true, silent = true }
		-- )
	end,
}
