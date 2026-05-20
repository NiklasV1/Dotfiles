local executeCommands = require("utils.utils").executeCommands
local goToFeaturePath = require("utils.work-utils").goToFeaturePath
local getBackendFeaturePath = require("utils.work-utils").getBackendFeaturePath

-- Commands
local UPDATE = "rush update" -- Changes lockfiles
local INSTALL = "rush install"
local BUILD_ONLY = "rush build-only"
local BUILD_FEATURE = "rush build-only --to ."
local GEN_CODE = "rush gen:code"
local START_FEATURE = "rushx start:feat"

-- Command functions
local function rushBuild()
	executeCommands({ INSTALL, BUILD_ONLY })
end

local function rushFull()
	executeCommands({ INSTALL, BUILD_ONLY, GEN_CODE, BUILD_ONLY })
end

local function rushXBuild()
	executeCommands({ goToFeaturePath(), BUILD_FEATURE })
end

local function rushStartFeat()
	executeCommands({ goToFeaturePath(), START_FEATURE })
end

local function rushXBuildQF()
	local feature_path = getBackendFeaturePath()
	local cmd = "cd " .. feature_path .. " && " .. BUILD_FEATURE
	local output_lines = {}

	vim.notify("Rush build started...", vim.log.levels.INFO)

	vim.fn.jobstart({ "bash", "-c", cmd }, {
		stdout_buffered = false,
		on_stdout = function(_, data)
			for _, line in ipairs(data) do
				table.insert(output_lines, line)
			end
		end,
		on_stderr = function(_, data)
			for _, line in ipairs(data) do
				table.insert(output_lines, line)
			end
		end,
		on_exit = function()
			local qf_items = {}
			local pattern = "^(.+)%((%d+),%d+%): error TS%d+: (.+)$"

			for _, line in ipairs(output_lines) do
				local file, lnum, msg = line:match(pattern)
				if file then
					table.insert(qf_items, {
						filename = feature_path .. file,
						lnum = tonumber(lnum),
						text = msg,
						type = "E",
					})
				end
			end

			if #qf_items == 0 then
				vim.notify("Rush build: No errors!", vim.log.levels.INFO)
			else
				vim.fn.setqflist(qf_items, "r")
				vim.notify("Rush build: " .. #qf_items .. " error(s) found", vim.log.levels.WARN)
				vim.cmd("bot copen")
			end
		end,
	})
end

-- Keybinds
local function loadKeybinds()
	vim.keymap.set("n", "<leader>rb", rushBuild, { desc = "[R]ush [B]uild" })
	vim.keymap.set("n", "<leader>rxb", rushXBuild, { desc = "[R]ush[X] [B]uild" })
	vim.keymap.set("n", "<leader>rf", rushFull, { desc = "[R]ush [F]ull" })
	vim.keymap.set("n", "<leader>rsf", rushStartFeat, { desc = "[R]ush [S]tart [F]eat" })
	vim.keymap.set("n", "<leader>rxq", rushXBuildQF, { desc = "[R]ush[X] [B]uild [Q]uickfix" })
end

-- Load keybinds
local rushCommandAutoGroup = vim.api.nvim_create_augroup("rushCommandAutoGroup", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "typescript", "javascript" },
	group = rushCommandAutoGroup,
	desc = "Apply jest commands to typescript files",
	callback = loadKeybinds,
})
