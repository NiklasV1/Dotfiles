local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath

-- SECTION: Commands
local UPDATE = "rush update"
local BUILD_ONLY = "rush build-only"
local BUILD_FEATURE = "rush build-only --to ."
local GEN_CODE = "rush gen:code"

-- SECTION: Command functions
local function rushBuild()
	executeCommands({ UPDATE, BUILD_ONLY })
end

local function rushFull()
	executeCommands({ UPDATE, BUILD_ONLY, GEN_CODE })
end

local function rushXBuild()
	executeCommands({ UPDATE, goToFeaturePath(), BUILD_FEATURE })
end

local function parseRushX()
	require("parsers.rush").parseRushX()
end

-- SECTION: Keybinds
vim.keymap.set("n", "<leader>rb", rushBuild, { desc = "[R]ush [B]uild" })

vim.keymap.set("n", "<leader>rxb", rushXBuild, { desc = "[R]ush[X] [B]uild" })

vim.keymap.set("n", "<leader>rf", rushFull, { desc = "[R]ush [F]ull" })

-- TODO: Fix this for monorepo use
vim.keymap.set("n", "<leader>rq", function()
	require("parsers.rush").parse()
end, { desc = "[R]ush [Q]uickfix" })

vim.keymap.set("n", "<leader>rxq", parseRushX, { desc = "[R]ush[X] [Q]uickfix" })
