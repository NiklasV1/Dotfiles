return {

	-- PNPM
	vim.api.nvim_create_user_command(
		"Pnpm",
		[[lua require("parsers.pnpm").parse()]],
		{ desc = "Parse pnpm output to quickfix list." }
	),

	-- Eslint_d
	vim.api.nvim_create_user_command(
		"Eslint",
		[[lua require("parsers.eslint").parse()]],
		{ desc = "Parse eslint output to quickfix list." }
	),
}
