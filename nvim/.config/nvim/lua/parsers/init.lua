return {

	-- Rushx feature build
	vim.api.nvim_create_user_command(
		"RushxFix",
		[[lua require("parsers.pnpm").parse()]],
		{ desc = "Parse pnpm output to quickfix list." }
	),

	-- Rush build
	vim.api.nvim_create_user_command(
		"Rush",
		[[lua require("parsers.rush").parse()]],
		{ desc = "Parse pnpm output to quickfix list." }
	),

	-- Jest
	vim.api.nvim_create_user_command(
		"Jest",
		[[lua require("parsers.jest").parse()]],
		{ desc = "Parse jest output to quickfix list." }
	),
	vim.api.nvim_create_user_command(
		"JestCurrent",
		[[!npm exec jest -- --testMatch='**/%:t']],
		{ desc = "Run current jest test" }
	),

	-- Eslint_d
	vim.api.nvim_create_user_command(
		"Eslint",
		[[lua require("parsers.eslint").parse()]],
		{ desc = "Parse eslint output to quickfix list." }
	),
}
