-- Diagnostics
local function buffer_diagnostics_to_quickfix(title, severity)
	local items = vim.diagnostic.toqflist(vim.diagnostic.get(0, { severity = severity }))

	if #items == 0 then
		vim.print("No diagnostics found.")
		return
	end

	vim.fn.setqflist({}, " ", { title = title, items = items })
	vim.cmd("bot copen")
end

vim.keymap.set("n", "<leader>sd", function()
	buffer_diagnostics_to_quickfix("Diagnostics", vim.diagnostic.severity.HINT)
end, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>se", function()
	buffer_diagnostics_to_quickfix("Errors", vim.diagnostic.severity.ERROR)
end, { desc = "[S]earch [E]rrors" })
