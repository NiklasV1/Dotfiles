local M = {}

M.setup = function(opencode)
	-- Basic keymaps
	vim.keymap.set({ "n", "x" }, "<leader>oa", function()
		opencode.command("session.new")
		opencode.ask("@this: ", { submit = true })
	end, { desc = "Ask opencode" })

	vim.keymap.set({ "n", "x" }, "<leader>ox", function()
		opencode.command("session.new")
		opencode.select()
	end, { desc = "Execute opencode action" })

	-- Basic predefined prompts
	vim.keymap.set({ "n", "x" }, "<leader>oe", function()
		opencode.command("session.new")
		opencode.prompt("explain", { submit = true })
	end, { desc = "Explain" })

	vim.keymap.set({ "n", "x" }, "<leader>oi", function()
		opencode.command("session.new")
		opencode.prompt("implement", { submit = true })
	end, { desc = "Implement" })

	vim.keymap.set({ "n", "x" }, "<leader>or", function()
		opencode.command("session.new")
		opencode.prompt("review", { submit = true })
	end, { desc = "Review" })

	vim.keymap.set({ "n", "x" }, "<leader>ot", function()
		opencode.command("session.new")
		opencode.prompt("test", { submit = true })
	end, { desc = "Test" })

	vim.keymap.set({ "n", "x" }, "<leader>od", function()
		opencode.command("session.new")
		opencode.prompt("document", { submit = true })
	end, { desc = "Document" })

	vim.keymap.set({ "n", "x" }, "<leader>oE", function()
		opencode.command("session.new")
		opencode.prompt("diagnostics", { submit = true })
	end, { desc = "Explain diagnostics" })

	vim.keymap.set({ "n", "x" }, "<leader>of", function()
		opencode.command("session.new")
		opencode.prompt("fix", { submit = true })
	end, { desc = "Fix diagnostics" })

	-- Session handling
	vim.keymap.set({ "n", "x" }, "<leader>osn", function()
		opencode.command("session.new")
	end, { desc = "New session" })

	-- Not sure how useful these are: maybe remove later
	vim.keymap.set({ "n", "x" }, "go", function()
		return opencode.operator("@this ")
	end, { desc = "Add range to opencode", expr = true })
	vim.keymap.set("n", "goo", function()
		return opencode.operator("@this ") .. "_"
	end, { desc = "Add line to opencode", expr = true })
end

return M
