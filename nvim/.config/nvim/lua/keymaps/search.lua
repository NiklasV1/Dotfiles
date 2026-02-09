-- Utils
local function buffer_diagnostics_to_quickfix(title, severity)
	local items = vim.diagnostic.toqflist(vim.diagnostic.get(0, { severity = severity }))

	if #items == 0 then
		vim.print("No diagnostics found.")
		return
	end

	vim.fn.setqflist({}, " ", { title = title, items = items })
	vim.cmd("bot copen")
end

-- Search diagnostics
vim.keymap.set("n", "<leader>sd", function()
	buffer_diagnostics_to_quickfix("Diagnostics", vim.diagnostic.severity.HINT)
end, { desc = "[S]earch [D]iagnostics" })

-- Search errors
vim.keymap.set("n", "<leader>se", function()
	buffer_diagnostics_to_quickfix("Errors", vim.diagnostic.severity.ERROR)
end, { desc = "[S]earch [E]rrors" })

-- Search current buffer
vim.keymap.set("n", "<leader>sb", function()
	local buffer = vim.fn.shellescape(vim.fn.expand("%")) or ""

	if buffer == "" then
		vim.print("No current buffer.")
		return
	end

	require("utils.input-window").create_input_window("Search buffer", nil, function(query)
		if query and query ~= "" then
			require("utils.grep").run_grep(query, false, { buffer }, "Current", false)
		else
			print("No search query.")
		end
	end)
end, { desc = "[S]earch [B]uffer" })

-- Search all open buffers
vim.keymap.set("n", "<leader>so", function()
	local buffers = {}
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			if name ~= "" and vim.fn.filereadable(name) == 1 then
				table.insert(buffers, vim.fn.shellescape(name))
			end
		end
	end

	if #buffers == 0 then
		vim.print("No open buffers.")
		return
	end

	require("utils.input-window").create_input_window("Search open buffers", nil, function(query)
		if query and query ~= "" then
			require("utils.grep").run_grep(query, false, buffers, "Buffers", false)
		else
			print("No search query.")
		end
	end)
end, { desc = "[S]earch [O]pen buffers" })

-- Search all files
vim.keymap.set("n", "<leader>sg", function()
	require("utils.input-window").create_input_window("Search all files", nil, function(query)
		if query and query ~= "" then
			require("utils.grep").run_grep(query, false, nil, "All", false)
		else
			print("No search query.")
		end
	end)
end, { desc = "[S]earch [G]rep" })

-- Search all files with regex
vim.keymap.set("n", "<leader>sr", function()
	require("utils.input-window").create_input_window("Search regex", nil, function(query)
		if query and query ~= "" then
			require("utils.grep").run_grep(query, false, nil, "Regex", true)
		else
			print("No search query.")
		end
	end)
end, { desc = "[S]earch [R]egex" })

-- Search word under cursor
vim.keymap.set("n", "<leader>sw", function()
	local word = vim.fn.expand("<cword>")
	if word and word ~= "" then
		require("utils.grep").run_grep(word, true, nil, "Word", false) -- case-sensitive
	else
		print("No word under cursor.")
	end
end, { desc = "[S]earch [W]ord" })

-- Search visual selection
vim.keymap.set("v", "<leader>sv", function()
	vim.cmd('normal! "vy')
	local selection = vim.fn.getreg("v")
	if selection and selection ~= "" then
		require("utils.grep").run_grep(selection, true, nil, "Selection", false) -- case-sensitive
	else
		print("No selection.")
	end
end, { desc = "[S]earch [V]isual selection" })

-- Search methods
vim.keymap.set("n", "<leader>sm", function()
	require("utils.quickfix.methods").get_symbols(vim.lsp.protocol.SymbolKind.Method)
end, { desc = "[S]earch [M]ethods" })

-- Search buffer names
vim.keymap.set(
	"n",
	"<leader><leader>",
	require("utils.quickfix.buffers").to_qflist,
	{ desc = "List of current buffers" }
)

-- TODO: Search keymaps

-- Search help tags
vim.keymap.set("n", "<leader>sh", require("utils.quickfix.helptags").to_qflist, { desc = "[S]earch [H]elp" })
