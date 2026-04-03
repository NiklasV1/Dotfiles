local M = {}

-- Module state
local current = {
	callback = nil,
	items = nil,
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

local function confirm(item, idx)
	local _callback = current.callback

	-- Reset state
	current.callback = nil
	current.items = nil
	close_window()

	-- Execute callback
	if _callback then
		_callback(item, idx)
	end
end

M.select = function(items, opts, on_choice)
	-- Assert items
	if not items or vim.tbl_isempty(items) then
		on_choice(nil, nil)
		vim.print("No items in selection.")
		return
	end

	-- Load options
	opts = opts or {}
	local prompt = opts.prompt or ""
	local format_item = opts.format_item or tostring

	-- Set state
	current.callback = on_choice
	current.items = items

	-- Create buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = true
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "vim_ui_select"
	current.buf = buf

	-- Create lines
	local lines = {}
	local max_width = prompt ~= "" and vim.api.nvim_strwidth(prompt) or 1

	for item_number, item in ipairs(items) do
		local line = item_number .. ". " .. format_item(item)
		max_width = math.max(max_width, vim.api.nvim_strwidth(line))
		table.insert(lines, line)
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	-- Open window
	local ui = vim.api.nvim_list_uis()[1]
	local height = #lines
	local width = max_width + 2
	local row = math.floor((ui.height - height) / 2)
	local col = math.floor((ui.width - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "bold",
		title = prompt ~= "" and " " .. prompt .. " " or nil,
		title_pos = "center",
	})
	vim.api.nvim_win_set_cursor(win, { 1, 0 })
	current.win = win

	-- Set keymaps
	local function map(lhs, fn)
		vim.keymap.set("n", lhs, fn, { buffer = buf, nowait = true })
	end

	map("<CR>", function()
		local item_row = vim.api.nvim_win_get_cursor(0)[1]
		confirm(items[item_row], item_row)
	end)

	map("<Esc>", function()
		confirm(nil, nil)
	end)

	map("q", function()
		confirm(nil, nil)
	end)

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = buf,
		once = true,
		callback = function()
			if current.callback then
				confirm(nil, nil)
			end
		end,
	})
end

return M
