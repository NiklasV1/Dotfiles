return {

	-- Rushx quickfix
	vim.api.nvim_create_user_command(
		"RushxFix",
		[[lua require("parsers.pnpm").parse()]],
		{ desc = "Parse rush feature build output to quickfix list." }
	),

	-- Rush build
	vim.api.nvim_create_user_command(
		"Rush",
		[[lua require("parsers.rush").parse()]],
		{ desc = "Parse rush build output to quickfix list." }
	),

	-- Jest
	vim.api.nvim_create_user_command(
		"Jest",
		[[edit term://rushx test:e2e]],
		{ desc = "Run jest tests of current feature" }
	),
	vim.api.nvim_create_user_command(
		"JestCurrent",
		[[edit term://npm exec jest -- --testMatch='**/%:t']],
		{ desc = "Run jest test of current buffer" }
	),

	-- Eslint
	vim.api.nvim_create_user_command(
		"Eslint",
		[[lua require("parsers.eslint").parse()]],
		{ desc = "Parse eslint output to quickfix list." }
	),
}
