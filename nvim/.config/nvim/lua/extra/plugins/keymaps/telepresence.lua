local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath

-- SECTION: Commands
local MISE_ENVIRONMENT = 'eval "$(mise env)"'
local START_FEATURE = "rushx start:feat"
local TELEPRESENCE_CONNECT = "mise r telepresence:connect"
local TELEPRESENCE_INTERCEPT = "mise r telepresence:intercept"
local TELEPRESENCE_QUIT = "mise r telepresence:quit"

-- SECTION: Command functions
local function telepresenceConnect()
	executeCommands({ TELEPRESENCE_CONNECT }, "INSERT")
end

local function telepresenceIntercept()
	executeCommands({ goToFeaturePath(), TELEPRESENCE_INTERCEPT }, "INSERT")
end

local function telepresenceQuit()
	executeCommands({ TELEPRESENCE_QUIT }, "INSERT")
end

local function telepresenceStart()
	executeCommands({ goToFeaturePath(), MISE_ENVIRONMENT, START_FEATURE })
end

-- SECTION: Keybinds
vim.keymap.set("n", "<leader>tc", telepresenceConnect, { desc = "[T]elepresence [C]onnect" })

vim.keymap.set("n", "<leader>ti", telepresenceIntercept, { desc = "[T]elepresence [I]ntercept" })

vim.keymap.set("n", "<leader>tq", telepresenceQuit, { desc = "[T]elepresence [Q]uit" })

vim.keymap.set("n", "<leader>ts", telepresenceStart, { desc = "[T]elepresence [S]tart" })
