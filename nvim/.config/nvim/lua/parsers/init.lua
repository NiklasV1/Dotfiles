return {

	-- NOTE: Rush
	vim.keymap.set("n", "<leader>rb", function()
		vim.cmd([[edit term://rush build-only]])
	end, { desc = "[R]ush [B]uild" }),

	vim.keymap.set("n", "<leader>rxb", function()
		vim.cmd([[edit term://rushx build]])
	end, { desc = "[R]ush[X] [B]uild" }),

	vim.keymap.set("n", "<leader>ru", function()
		vim.cmd([[edit term://rush update]])
	end, { desc = "[R]ush [U]pdate" }),

	vim.keymap.set("n", "<leader>rc", function()
		vim.cmd([[edit term://rush gen:code]])
	end, { desc = "[R]ush [C]ode" }),

	vim.keymap.set("n", "<leader>rf", function()
		vim.cmd([[edit term://rush update && rush build-only && rush gen:code]])
	end, { desc = "[R]ush [F]ull" }),

	-- NOTE: Rush quickfix
	vim.keymap.set("n", "<leader>rq", function()
		require("parsers.rush").parse()
	end, { desc = "[R]ush [Q]uickfix" }),

	vim.keymap.set("n", "<leader>rxq", function()
		require("parsers.pnpm").parse()
	end, { desc = "[R]ush[X] [Q]uickfix" }),

	-- NOTE: Jest
	vim.keymap.set("n", "<leader>je", function()
		vim.cmd([[edit term://npm exec jest -- --test-path-pattern='[.]e2e-spec[.]js$']])
	end, { desc = "[J]est [E]nd-to-end" }),

	vim.keymap.set("n", "<leader>ju", function()
		vim.cmd([[edit term://npm exec jest -- --test-path-pattern='[.]spec[.]js$']])
	end, { desc = "[J]est [U]nit tests" }),

	vim.keymap.set("n", "<leader>jc", function()
		vim.cmd([[edit term://npm exec jest -- --testMatch='**/%:t']])
	end, { desc = "[J]est [C]urrent test" }),

	vim.keymap.set("n", "<leader>jt", function()
		vim.cmd([[edit %:h:s?dist?src?/%:t:r.ts]])
	end, { desc = "[J]est finc [T]ypescript test" }),

	-- NOTE: VsCode (Debugger)
	vim.api.nvim_create_user_command("Debugger", [[!code %]], { desc = "Open Debugger" }),

	-- NOTE: Eslint
	vim.api.nvim_create_user_command(
		"Eslint",
		[[lua require("parsers.eslint").parse()]],
		{ desc = "Parse eslint output to quickfix list." }
	),
}
