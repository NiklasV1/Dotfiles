local getFeaturePath = require("utils.work-utils").getBackendFeaturePath

local function parseOutput(output)
	local quickfixEntries = {}

	local _, count = string.gsub(
		output,
		"(src/[%w_%-/]*%.[%w_%-%.]*)%((%d*),%d*%): [^:]*: ([^\n]*)",
		function(path, line, message)
			table.insert(quickfixEntries, {
				filename = vim.fs.find(path, { type = "file" }),
				lnum = line,
				type = "E",
				text = string.sub(message, 1, 100) .. "...",
			})
		end
	)

	return quickfixEntries, count
end

return {
	parseRushX = function()
		print("Running rushx build.")

		local featurePath = getFeaturePath()
		local output = vim.system({ "rushx", "build" }, { cwd = featurePath }):wait().stdout
		local quickfixEntries = {}

		if output == nil then
			print("No rushx output found.")
			return
		end

		local _, count = string.gsub(
			output,
			"(src/[%w_%-/]*%.[%w_%-%.]*)%((%d*),%d*%): [^:]*: ([^\n]*)",
			function(path, line, message)
				table.insert(quickfixEntries, {
					filename = featurePath .. path,
					lnum = line,
					type = "E",
					text = string.sub(message, 1, 100) .. "...",
				})
			end
		)

		if count > 0 then
			vim.fn.setqflist(quickfixEntries)
			vim.api.nvim_command("copen")
		else
			print("No errors found.")
		end
	end,

	parseRush = function()
		print("Running rush build.")

		local output = vim.system({ "rush", "build-only" }):wait().stdout

		if output == nil then
			print("No rush output found.")
			return
		end

		local quickfixEntries, count = parseOutput(output)

		if count > 0 then
			vim.fn.setqflist(quickfixEntries)
			vim.api.nvim_command("copen")
		else
			print("No errors found.")
		end
	end,
}
