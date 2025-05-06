return {
	parse = function()
		print("Running eslint_d build.")
		print("...")
		local quickfixEntries = {}
		local output = vim.fn.system({ "eslint_d", "--cache" })
		print(output)
		local _, count = string.gsub(
			output,
			"(/[%w_%-/]*%.[%w_%-%.]*)%((%d*),%d*%): [^:]*: ([^\n]*)",
			function(path, line, message)
				table.insert(quickfixEntries, {
					filename = path,
					lnum = line,
					type = "E",
					text = message,
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
