local function create_note(name, folder)
	if not name or name == "" then
		vim.print("Please enter a name.")
		return
	end

	local filename = string.gsub(name, " ", "_")

	vim.cmd("edit " .. folder .. "/" .. filename .. ".md")
	vim.api.nvim_buf_set_lines(0, 0, 3, false, { "# " .. filename, "", "" })
	vim.cmd("silent write")

	local line = math.min(3, vim.api.nvim_buf_line_count(0))
	vim.api.nvim_win_set_cursor(0, { line, 0 })
	vim.cmd("startinsert")
end

-- Daily note
vim.keymap.set("n", "<leader>nd", function()
	local currentNotePath = "~/Notes/Daily-Notes/" .. os.date("%d-%m-%Y") .. ".md"
	vim.cmd("edit " .. currentNotePath)
end, { desc = "[N]otes [D]aily" })

-- Create inbox note
vim.keymap.set("n", "<leader>ni", function()
	require("utils.input-window").create_input_window("Create inbox note", nil, function(name)
		create_note(name, "~/Notes/\\$1_in")
	end)
end, { desc = "[N]otes [I]nbox" })

-- Create knowledge note
vim.keymap.set("n", "<leader>nk", function()
	require("utils.input-window").create_input_window("Create knowledge note", nil, function(name)
		create_note(name, "~/Notes")
	end)
end, { desc = "[N]otes [K]nowledge" })

-- Search notes
vim.keymap.set("n", "<leader>ng", function()
	require("utils.input-window").create_input_window("Search notes", nil, function(query)
		require("utils.grep").run_grep(query, false, { "~/Notes/**" }, "Notes", false)
	end)
end, { desc = "[N]otes [G]rep" })

-- Maybe for the future:
-- Move note to $schedule
-- Move note to $projects
-- Move note to $done
