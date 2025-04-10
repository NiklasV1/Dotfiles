-- NOTE: Keymap files

-- Jest keymaps
require("extra.plugins.keymaps.jest")

-- Jest keymaps
require("extra.plugins.keymaps.rush")

-- Quickfix list keymaps
require("extra.plugins.keymaps.quickfix")

-- NOTE: Misc keymaps

-- VsCode (Debugger)
vim.api.nvim_create_user_command("Debugger", [[!code %]], { desc = "Open Debugger" })

-- Eslint
vim.api.nvim_create_user_command(
	"Eslint",
	[[lua require("parsers.eslint").parse()]],
	{ desc = "Parse eslint output to quickfix list." }
)
