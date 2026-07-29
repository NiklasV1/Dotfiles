local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath

-- Commands
local INSTALL = "pnpm install"
local BUILD = "pnpm build"
local GEN_CODE = "pnpm gen:code"

-- Command functions
local function build()
	executeCommands({ INSTALL, BUILD }, "", "zsh")
end

local function buildFeature()
	executeCommands({ goToFeaturePath(), BUILD }, "", "zsh")
end

local function genCode()
	executeCommands({ INSTALL, BUILD, GEN_CODE }, "", "zsh")
end

-- Keybinds
local function loadKeybinds()
	vim.keymap.set("n", "<leader>rb", build, { desc = "[R][B]uild" })
	vim.keymap.set("n", "<leader>rxb", buildFeature, { desc = "[R][X][B]uild" })
	vim.keymap.set("n", "<leader>rg", genCode, { desc = "[R][G]en" })
end

-- Load keybinds
local pnpmCommandAutoGroup = vim.api.nvim_create_augroup("pnpmCommandAutoGroup", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "typescript", "javascript" },
	group = pnpmCommandAutoGroup,
	desc = "Apply pnpm commands to typescript files",
	callback = loadKeybinds,
})
