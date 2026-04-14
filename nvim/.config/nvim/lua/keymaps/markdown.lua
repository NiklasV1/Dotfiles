vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(ev)
		vim.keymap.set("n", "<leader>C", function()
			local line = vim.api.nvim_get_current_line()
			if line:match("%[x%]") then
				vim.cmd("keeppatterns s/\\[x\\]/[ ]/e")
			elseif line:match("%[ %]") then
				vim.cmd("keeppatterns s/\\[ \\]/[x]/e")
			end
		end, { buffer = ev.buf, desc = "Toggle markdown checkbox" })
	end,
})
