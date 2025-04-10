-- NOTE: Jest
vim.keymap.set("n", "<leader>je", function()
	vim.cmd([[edit term://npm exec jest -- --test-path-pattern='[.]e2e-spec[.]js$']])
end, { desc = "[J]est [E]nd-to-end" })

vim.keymap.set("n", "<leader>ju", function()
	vim.cmd([[edit term://npm exec jest -- --test-path-pattern='[.]spec[.]js$']])
end, { desc = "[J]est [U]nit tests" })

vim.keymap.set("n", "<leader>jc", function()
	vim.cmd([[edit term://npm exec jest -- --testMatch='**/%:t']])
end, { desc = "[J]est [C]urrent test" })

vim.keymap.set("n", "<leader>jt", function()
	vim.cmd([[edit %:h:s?dist?src?/%:t:r.ts]])
end, { desc = "[J]est finc [T]ypescript test" })
