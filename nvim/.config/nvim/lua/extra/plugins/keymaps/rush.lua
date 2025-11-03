local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath

-- SECTION: Commands
local MISE_ENVIRONMENT = 'eval "$(mise env)"'
local UPDATE = "rush update"
local BUILD_ONLY = "rush build-only"
local BUILD_FEATURE = "rush build-only --to ."
local GEN_CODE = "rush gen:code"
local START_FEATURE = "rushx start:feat"
local BUILD_ONLY_FEATURE = "rushx build"

-- SECTION: Command functions
local function rushBuild()
	executeCommands({ UPDATE, BUILD_ONLY })
end

local function rushFull()
	executeCommands({ UPDATE, BUILD_ONLY, GEN_CODE, BUILD_ONLY })
end

local function rushXBuild()
	executeCommands({ goToFeaturePath(), BUILD_FEATURE })
end

local function parseRush()
	require("parsers.rush").parseRush()
end

local function parseRushX()
	require("parsers.rush").parseRushX()
end

local function rushStartFeat()
	executeCommands({ goToFeaturePath(), START_FEATURE })
end

-- SECTION: Keybinds
vim.keymap.set("n", "<leader>rb", rushBuild, { desc = "[R]ush [B]uild" })

vim.keymap.set("n", "<leader>rxb", rushXBuild, { desc = "[R]ush[X] [B]uild" })

vim.keymap.set("n", "<leader>rf", rushFull, { desc = "[R]ush [F]ull" })

vim.keymap.set("n", "<leader>rq", parseRush, { desc = "[R]ush [Q]uickfix" })

vim.keymap.set("n", "<leader>rxq", parseRushX, { desc = "[R]ush[X] [Q]uickfix" })

vim.keymap.set("n", "<leader>rsf", rushStartFeat, { desc = "[R]ush [S]tart [F]eat" })
