local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath

-- Commands
local END_TO_END = "npm exec jest -- --test-path-pattern='[.]e2e-spec[.]js$'"
local UNIT_TESTS = "npm exec jest -- --test-path-pattern='[.]spec[.]js$'"
local CURRENT_TEST = "npm exec jest -- --testMatch='**/%:t'"

-- Command functions
local function jestEndToEnd()
	executeCommands({ goToFeaturePath(), END_TO_END })
end

local function jestUnitTests()
	executeCommands({ goToFeaturePath(), UNIT_TESTS })
end

local function jestCurrentTest()
	executeCommands({ goToFeaturePath(), CURRENT_TEST })
end

-- Keybinds
local function loadKeybinds()
	vim.keymap.set("n", "<leader>je", jestEndToEnd, { desc = "[J]est [E]nd-to-end" })
	vim.keymap.set("n", "<leader>ju", jestUnitTests, { desc = "[J]est [U]nit tests" })
	vim.keymap.set("n", "<leader>jc", jestCurrentTest, { desc = "[J]est [C]urrent test" })
end

-- Load keybinds
local jestCommandAutoGroup = vim.api.nvim_create_augroup("jestCommandAutoGroup", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "typescript", "javascript" },
	group = jestCommandAutoGroup,
	desc = "Apply jest commands to typescript files",
	callback = loadKeybinds,
})
