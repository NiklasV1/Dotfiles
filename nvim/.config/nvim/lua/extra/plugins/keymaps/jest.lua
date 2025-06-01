local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath

-- SECTION: Commands
local END_TO_END = "npm exec jest -- --test-path-pattern='[.]e2e-spec[.]js$'"
local UNIT_TESTS = "npm exec jest -- --test-path-pattern='[.]spec[.]js$'"
local CURRENT_TEST = "npm exec jest -- --testMatch='**/%:t'"

-- SECTION: Command functions
local function jestEndToEnd()
	executeCommands({ goToFeaturePath(), END_TO_END })
end

local function jestUnitTests()
	executeCommands({ goToFeaturePath(), UNIT_TESTS })
end

local function jestCurrentTest()
	executeCommands({ goToFeaturePath(), CURRENT_TEST })
end

local function jestQuickfixEndToEnd()
	require("parsers.jest").jestEndToEnd()
end

local function jestQuickfixUnit()
	require("parsers.jest").jestUnitTest()
end

local function findTypescriptTest()
	vim.cmd([[edit %:h:s?dist?src?/%:t:r.ts]])
end

-- SECTION: Keybinds
local function loadKeybinds()
	vim.keymap.set("n", "<leader>je", jestEndToEnd, { desc = "[J]est [E]nd-to-end" })

	vim.keymap.set("n", "<leader>ju", jestUnitTests, { desc = "[J]est [U]nit tests" })

	vim.keymap.set("n", "<leader>jc", jestCurrentTest, { desc = "[J]est [C]urrent test" })

	vim.keymap.set("n", "<leader>jqu", jestQuickfixUnit, { desc = "[J]est [Q]uickfix [U]nit tests" })

	vim.keymap.set("n", "<leader>jqe", jestQuickfixEndToEnd, { desc = "[J]est [Q]uickfix [E]nt to end" })

	vim.keymap.set("n", "<leader>jt", findTypescriptTest, { desc = "[J]est find [T]ypescript test" })
end

-- SECTION: Load keybinds
local jestCommands = vim.api.nvim_create_augroup("jestCommands", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "typescript", "javascript" },
	group = jestCommands,
	desc = "Apply jest commands to typescript files",
	callback = loadKeybinds,
})
