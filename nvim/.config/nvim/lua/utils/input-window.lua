local U = {}

U.create_input_window = function(prompt, default, on_submit)
	local buf = vim.api.nvim_create_buf(false, true)
	local width = 60
	local height = 1
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "single",
		title = " " .. prompt .. " ",
		title_pos = "center",
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { default or "" })
	vim.cmd("startinsert!")

	-- Set up keymaps
	vim.keymap.set("i", "<CR>", function()
		local line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
		vim.api.nvim_win_close(win, true)
		vim.schedule(function()
			on_submit(line)
		end)
	end, { buffer = buf })

	vim.keymap.set("i", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
		vim.cmd("stopinsert")
	end, { buffer = buf })

	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })
end

return U
