-- Quickfix list
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setqflist, { desc = "[Q]uickfix [D]iagnostics" })
vim.keymap.set("n", "<leader>qf", "<Cmd>cfirst<CR>", { desc = "[Q]uickfix [F]irst" })
vim.keymap.set("n", "<leader>ql", "<Cmd>clast<CR>", { desc = "[Q]uickfix [L]ast" })
vim.keymap.set("n", "<leader>qo", "<Cmd>copen<CR>", { desc = "[Q]uickfix [O]pen" })
vim.keymap.set("n", "<leader>qc", "<Cmd>cclose<CR>", { desc = "[Q]uickfix [C]lose" })
