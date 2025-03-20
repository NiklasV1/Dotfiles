return {
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
