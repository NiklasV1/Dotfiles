local getFeaturePath = require("utils.work-utils").getBackendFeaturePath

local function getTsTestFile(path)
	local output, _ = string.gsub(path, "%/dist%/", "/src/", 1)

	output, _ = string.gsub(output, "%.js", ".ts", 1)

	return output
end

local function parseJest(output, featurePath)
	local quickfixEntries = {}

	local _, count = string.gsub(output, "FAIL ([%w_%-/]*%.[%w_%-%.]*) ", function(path)
		table.insert(quickfixEntries, {
			filename = getTsTestFile(featurePath .. path),
			type = "E",
		})
	end)

	return quickfixEntries, count
end

return {
	jestUnitTest = function()
		print("Running unit tests.")

		local featurePath = getFeaturePath()
		local output =
			vim.system({ "npm", "exec", "jest", "--", "--test-path-pattern='[.]spec[.]js$'" }, { cwd = featurePath })
				:wait().stdout

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
			{ cwd = featurePath }
		):wait()

		print(output.stdout)
		print(output.stderr)

		if output == nil then
			print("No jest output found.")
			return
		end

		local quickfixEntries, count = parseJest(output.stdout, featurePath)

		if count > 0 then
			vim.fn.setqflist(quickfixEntries)
			vim.api.nvim_command("copen")
		else
			print("No errors found.")
		end
	end,

	parse = function()
		print("Running tests.")
		print("...")

		local quickfixEntries = {}

		local output = vim.fn.system({ "pnpm", "jest", "--color=false" })
		local _, failedCount = string.gsub(output, "FAIL ([%w_%-/]*%.[%w_%-%.]*) ", function(path)
			table.insert(quickfixEntries, {
				filename = path,
				lnum = 0,
				type = "E",
				text = "",
			})
		end)

		local _, passedCount = string.gsub(output, "PASS [%w_%-/]*%.[%w_%-%.]*", "")

		print("Tests complete.")
		print("Tests passed: " .. passedCount)
		print("Tests failed: " .. failedCount)

		if failedCount > 0 then
			vim.fn.setqflist(quickfixEntries)
			vim.api.nvim_command("copen")
		end
	end,
}
