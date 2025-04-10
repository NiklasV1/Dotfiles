-- NOTE: Rush
vim.keymap.set("n", "<leader>rb", function()
	vim.cmd([[edit term://rush build-only]])
end, { desc = "[R]ush [B]uild" })

vim.keymap.set("n", "<leader>rxb", function()
	vim.cmd([[edit term://rushx build]])
end, { desc = "[R]ush[X] [B]uild" })

vim.keymap.set("n", "<leader>ru", function()
	vim.cmd([[edit term://rush update]])
end, { desc = "[R]ush [U]pdate" })

vim.keymap.set("n", "<leader>rc", function()
	vim.cmd([[edit term://rush gen:code]])
end, { desc = "[R]ush [C]ode" })

vim.keymap.set("n", "<leader>rf", function()
	vim.cmd([[edit term://rush update && rush build-only && rush gen:code]])
end, { desc = "[R]ush [F]ull" })

-- NOTE: Rush quickfix
vim.keymap.set("n", "<leader>rq", function()
	require("parsers.rush").parse()
end, { desc = "[R]ush [Q]uickfix" })

vim.keymap.set("n", "<leader>rxq", function()
	require("parsers.pnpm").parse()
end, { desc = "[R]ush[X] [Q]uickfix" })
