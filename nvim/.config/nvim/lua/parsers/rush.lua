local getFeaturePath = require("utils.work-utils").getBackendFeaturePath

return {
	parseRush = function() end,

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

	parse = function()
		print("Running rush build.")
		print("...")
		local quickfixEntries = {}
		local output = vim.fn.system({ "rush", "build-only" })
		local _, count = string.gsub(
			output,
			"(src/[%w_%-/]*%.[%w_%-%.]*)%((%d*),%d*%): [^:]*: ([^\n]*)",
			function(path, line, message)
				table.insert(quickfixEntries, {
					filename = path,
					lnum = line,
					type = "E",
					text = string.sub(message, 1, 100) .. "...",
				})
			end
		)
		print("Build complete.")
		if count > 0 then
			vim.fn.setqflist(quickfixEntries)
			print("Found " .. count .. " errors!")
			vim.api.nvim_command("copen")
		else
			print("No errors found.")
		end
	end,
}
