-- NOTE: Keymap files

-- Jest keymaps
require("extra.plugins.keymaps.jest")

-- Rush keymaps
require("extra.plugins.keymaps.rush")

-- Quickfix list keymaps
require("extra.plugins.keymaps.quickfix")

-- NOTE: Misc keymaps

-- VsCode (Debugger)
vim.keymap.set("n", "<leader>gd", function()
	local cursorPosition = vim.fn.getpos(".")
	local lineNr = cursorPosition[2]
	local colNr = cursorPosition[3]
	vim.cmd("!code -g %:S:" .. lineNr .. ":" .. colNr)
end, { desc = "[G]o to [D]ebugger" })

-- Eslint
vim.api.nvim_create_user_command(
	"Eslint",
	[[lua require("parsers.eslint").parse()]],
	{ desc = "Parse eslint output to quickfix list." }
)

-- Notes
vim.keymap.set("n", "<leader>N", function()
	local currentNotePath = "~/Notes/Daily-Notes/" .. os.date("%d-%m-%Y") .. ".md"
	vim.cmd("edit " .. currentNotePath)
end, { desc = "[N]otes" })
