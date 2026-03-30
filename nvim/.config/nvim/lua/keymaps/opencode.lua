local executeCommands = require("utils.utils").executeCommands

-- Commands
local OPENCODE_RUN = "opencode --prompt"
local CURRENT_FILE = "Please take a look at this file: @"
local DIVIDER = "  Prompt: "

local function runOpencode(prompt)
	local command = OPENCODE_RUN .. " " .. vim.fn.shellescape(prompt)
	executeCommands({ command })
end

-- Command functions
local function runPrompt()
	vim.ui.input({ prompt = "Prompt" }, function(prompt)
		if prompt and prompt ~= "" then
			runOpencode(prompt)
		else
			print("No prompt.")
		end
	end)
end

local function runPromptOnCurrentFile()
	vim.ui.input({ prompt = "Prompt current file" }, function(prompt)
		if prompt and prompt ~= "" then
			local currentFilePrompt = CURRENT_FILE .. vim.fn.expand("%")
			runOpencode(currentFilePrompt .. DIVIDER .. prompt)
		else
			print("No prompt.")
		end
	end)
end

-- Keybinds
local function loadKeybinds()
	vim.keymap.set("n", "<leader>op", runPrompt, { desc = "[O]pencode [P]rompt" })
	vim.keymap.set("n", "<leader>of", runPromptOnCurrentFile, { desc = "[O]pencode [F]ile" })
end

loadKeybinds()
