return {
	-- NOTE: Helper function for executing commands in the built-in terminal
	executeCommands = function(commands, cursorMode, terminalMode)
		local command = ""
		for i, com in ipairs(commands) do
			if i == 1 then
				command = com
			else
				command = command .. " && " .. com
			end
		end

		if terminalMode == "zsh" then
			vim.cmd("split | term zsh -c '" .. command .. "'")
		else
			vim.cmd("split term://" .. command)
		end

		if cursorMode == "INSERT" then
			vim.cmd("normal A")
			return
		end

		vim.cmd("normal G")
	end,
}
