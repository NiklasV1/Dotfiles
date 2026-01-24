-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, { desc = "Code [A]ction" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "gri", vim.lsp.buf.type_definition, { desc = "[G]oto [T]ype definition" })
vim.keymap.set("n", "<leader>si", vim.lsp.buf.incoming_calls, { desc = "[S]earch [I]ncoming" })
vim.keymap.set("n", "<leader>so", vim.lsp.buf.outgoing_calls, { desc = "[S]earch [O]utgoing" })

-- Common command typos
vim.api.nvim_create_user_command("W", ":w", {})
vim.api.nvim_create_user_command("Wa", ":wa", {})
vim.api.nvim_create_user_command("Wq", ":wq", {})

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "G", "Gzz", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- Splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>v", function()
	vim.cmd("vsplit")
end, { desc = "Split [V]ertically" })

-- Buffers
vim.keymap.set("n", "<leader>bd", function()
	vim.cmd("bdelete")
end, { desc = "[B]uffer [D]elete" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Yanking
vim.keymap.set("n", "<leader>yf", function()
	vim.cmd('let @+ = expand("%:.")')
end, { desc = "[Y]ank [F]ilename" })

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlightYankGroup", { clear = true }),
	callback = function()
		if vim.v.event.operator == "y" then
			vim.highlight.on_yank()
		end
	end,
})

-- Notes
vim.keymap.set("n", "<leader>N", function()
	local currentNotePath = "~/Notes/Daily-Notes/" .. os.date("%d-%m-%Y") .. ".md"
	vim.cmd("edit " .. currentNotePath)
end, { desc = "[N]otes" })

-- Quickfix list
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setqflist, { desc = "[Q]uickfix [D]iagnostics" })
vim.keymap.set("n", "<leader>qf", "<Cmd>cfirst<CR>", { desc = "[Q]uickfix [F]irst" })
vim.keymap.set("n", "<leader>ql", "<Cmd>clast<CR>", { desc = "[Q]uickfix [L]ast" })
vim.keymap.set("n", "<leader>qo", "<Cmd>copen<CR>", { desc = "[Q]uickfix [O]pen" })
vim.keymap.set("n", "<leader>qc", "<Cmd>cclose<CR>", { desc = "[Q]uickfix [C]lose" })

-- Execute keymap
require("keymaps.execute")

-- Angular file keymaps
require("keymaps.angular")

-- Rush keymaps
require("keymaps.rush")

-- Jest keymaps
require("keymaps.jest")

-- Telepresence keymaps
require("keymaps.telepresence")

-- Golang keymaps
require("keymaps.go")
