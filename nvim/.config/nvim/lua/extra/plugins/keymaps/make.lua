-- NOTE: Makefile keybinds
vim.keymap.set("n", "<leader>mm", function()
	vim.cmd([[!make]])
end, { desc = "[M]ake" })

vim.keymap.set("n", "<leader>mb", function()
	vim.cmd([[!make build]])
end, { desc = "[M]ake [B]uild" })

vim.keymap.set("n", "<leader>mf", function()
	vim.cmd([[!make format]])
end, { desc = "[M]ake [F]ormat" })

vim.keymap.set("n", "<leader>ml", function()
	vim.cmd([[!make lint]])
end, { desc = "[M]ake [L]int" })

vim.keymap.set("n", "<leader>mt", function()
	vim.cmd([[!make test]])
end, { desc = "[M]ake [T]est" })

vim.keymap.set("n", "<leader>mc", function()
	vim.cmd([[!make clean]])
end, { desc = "[M]ake [C]lean" })
