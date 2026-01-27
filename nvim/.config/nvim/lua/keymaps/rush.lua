local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath

-- Commands
local UPDATE = "rush update"
local BUILD_ONLY = "rush build-only"
local BUILD_FEATURE = "rush build-only --to ."
local GEN_CODE = "rush gen:code"
local START_FEATURE = "rushx start:feat"

-- Command functions
local function rushBuild()
	executeCommands({ UPDATE, BUILD_ONLY })
end

local function rushFull()
	executeCommands({ UPDATE, BUILD_ONLY, GEN_CODE, BUILD_ONLY })
end

local function rushXBuild()
	executeCommands({ goToFeaturePath(), BUILD_FEATURE })
end

local function rushStartFeat()
	executeCommands({ goToFeaturePath(), START_FEATURE })
end

-- Keybinds
local function loadKeybinds()
	vim.keymap.set("n", "<leader>rb", rushBuild, { desc = "[R]ush [B]uild" })
	vim.keymap.set("n", "<leader>rxb", rushXBuild, { desc = "[R]ush[X] [B]uild" })
	vim.keymap.set("n", "<leader>rf", rushFull, { desc = "[R]ush [F]ull" })
	vim.keymap.set("n", "<leader>rsf", rushStartFeat, { desc = "[R]ush [S]tart [F]eat" })
end

-- Load keybinds
local rushCommandAutoGroup = vim.api.nvim_create_augroup("rushCommandAutoGroup", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "typescript", "javascript" },
	group = rushCommandAutoGroup,
	desc = "Apply jest commands to typescript files",
	callback = loadKeybinds,
})
