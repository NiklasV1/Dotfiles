local M = {}

-- Module state
local current = {
	win = nil,
	buf = nil,
}

local function close_window()
	-- Close window
	if current.win and vim.api.nvim_win_is_valid(current.win) then
		vim.api.nvim_win_close(current.win, true)
	end

	-- Reset state
	current.win = nil
	current.buf = nil
end

M.input = function(opts, on_submit)
	-- Load options
	opts = opts or {}
	local prompt = opts.prompt or ""
	local default = opts.default or ""

	-- Create buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = true
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "vim_ui_input"
	current.buf = buf

	-- Set default text
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { default })

	-- Open window
	local ui = vim.api.nvim_list_uis()[1]
	local width = 62
	local height = 1
	local row = math.floor((ui.height - height) / 2)
	local col = math.floor((ui.width - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "single",
		title = prompt ~= "" and " " .. prompt .. " " or nil,
		title_pos = "center",
	})
	current.win = win
	vim.cmd("startinsert!")

	local function submit(result)
		close_window()
		vim.schedule(function()
			on_submit(result)
		end)
	end

	-- Set keymaps
	vim.keymap.set("i", "<CR>", function()
		local line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
		submit(line)
	end, { buffer = buf })

	vim.keymap.set("i", "<Esc>", function()
		submit(nil)
		vim.cmd("stopinsert")
	end, { buffer = buf })

	vim.keymap.set("n", "<Esc>", function()
		submit(nil)
	end, { buffer = buf })
end

return M
