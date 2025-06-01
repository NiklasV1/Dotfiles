local getFeaturePath = require("utils.work-utils").getBackendFeaturePath

-- @input output: takes stderr of the jest command
-- @input featurePath: current feature path of the tests
local function parseJest(output, featurePath)
	local quickfixEntries = {}

	local _, count = string.gsub(
		output,
		"%((src/[%w_%-/]*%.[%w_%-%.]*):([%d]*):([%d]*)%)",
		function(path, lineNumber, colNumber)
			table.insert(quickfixEntries, {
				filename = featurePath .. path,
				lnum = lineNumber,
				col = colNumber,
				type = "E",
			})
		end
	)

	return quickfixEntries, count
end

return {
	jestUnitTest = function()
		print("Running unit tests.")

		local featurePath = getFeaturePath()
		local output =
			vim.system({ "npm", "exec", "jest", "--", "--test-path-pattern='[.]spec[.]js$'" }, { cwd = featurePath })
				:wait().stderr

		if output == nil then
			print("No jest output found.")
			return
		end

		local quickfixEntries, count = parseJest(output, featurePath)

		if count > 0 then
			vim.fn.setqflist(quickfixEntries)
			vim.api.nvim_command("copen")
		else
			print("No errors found.")
		end
	end,

	jestEndToEnd = function()
		print("Running end-to-end tests.")

		local featurePath = getFeaturePath()
		local output = vim.system(
			{ "npm", "exec", "jest", "--", "--test-path-pattern='[.]e2e-spec[.]js$'" },
			{ cwd = featurePath, text = true }
		)
			:wait().stderr

		if output == nil then
			print("No jest output found.")
			return
		end

		local quickfixEntries, count = parseJest(output, featurePath)

		if count > 0 then
			vim.fn.setqflist(quickfixEntries)
			vim.api.nvim_command("copen")
		else
			print("No errors found.")
		end
	end,
}
