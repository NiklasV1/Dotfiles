local M = {}

M.to_qflist = function()
	local qf_items = {}

	-- Get all listed buffers
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })

	for _, buf in ipairs(buffers) do
		local bufnr = buf.bufnr
		local name = buf.name

		-- Skip if no name
		if name ~= "" then
			-- Get buffer info
			local modified = vim.bo[bufnr].modified and "[+]" or ""
			local readonly = vim.bo[bufnr].readonly and "[RO]" or ""
			local hidden = buf.hidden == 1 and "[hidden]" or ""
			local flags = table.concat({ modified, readonly, hidden }, " ")

			-- Build text with buffer number and flags
			local text = string.format("[%d] %s %s", bufnr, flags, vim.fn.fnamemodify(name, ":t"))

			table.insert(qf_items, {
				filename = name,
				lnum = buf.lnum or 1, -- Last cursor position in buffer
				text = text,
			})
		end
	end

	-- Sort by buffer number
	table.sort(qf_items, function(a, b)
		local a_num = tonumber(a.text:match("%[(%d+)%]"))
		local b_num = tonumber(b.text:match("%[(%d+)%]"))
		return a_num < b_num
	end)

	vim.fn.setqflist({}, " ", { items = qf_items, title = "Buffers" })
	vim.cmd("bot copen")

	print(string.format("Added %d buffers to quickfix list", #qf_items))
end

return M
