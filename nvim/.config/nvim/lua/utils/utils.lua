return {
	-- NOTE: Helper function for executing commands in the built-in terminal
	executeCommands = function(commands)
		local command = ""
		for i, com in ipairs(commands) do
			if i == 1 then
				command = com
			else
				command = command .. " && " .. com
			end
		end
		vim.cmd("split term://" .. command)
	end,
}
