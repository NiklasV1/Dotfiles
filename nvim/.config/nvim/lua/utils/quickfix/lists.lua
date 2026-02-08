local M = {}

M.select = function()
	-- Get total number of quickfix lists
	local total = vim.fn.getqflist({ nr = "$" }).nr
	local current = vim.fn.getqflist({ nr = 0 }).nr

	if total == 0 then
		vim.print("No quickfix lists in history.")
		return
	end

	-- Build list of options
	local items = {}
	for i = 1, total do
		local qf_info = vim.fn.getqflist({ nr = i, title = 0, size = 0 })
		local title = qf_info.title ~= "" and qf_info.title or "Untitled"
		local size = qf_info.size
		local is_current = (i == current) and " ✓" or ""

		table.insert(items, {
			nr = i,
			display = string.format("[%d] %s (%d items)%s", i, title, size, is_current),
		})
	end

	vim.ui.select(items, {
		prompt = "Select quickfix list:",
		format_item = function(item)
			return item.display
		end,
	}, function(choice)
		if choice then
			vim.cmd("silent " .. choice.nr .. "chistory")
			vim.cmd("bot copen")
		end
	end)
end

return M
