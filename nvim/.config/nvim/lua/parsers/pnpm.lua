return {
	parse = function()
		print("Running rushx build.")
		print("...")
		local quickfixEntries = {}
		local output = vim.fn.system({ "rushx", "build" })
		string.gsub(output, "(src/[%w_%-/]*%.[%w_%-%.]*)%((%d*),%d*%): [^:]*: ([^\n]*)", function(path, line, message)
			table.insert(quickfixEntries, {
				filename = path,
				lnum = line,
				type = "E",
				text = message,
			})
		end)
		vim.fn.setqflist(quickfixEntries)
		print("Build complete.")
		vim.api.nvim_command("copen")
	end,
}
