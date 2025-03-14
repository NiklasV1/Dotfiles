return {

	-- PNPM
	vim.api.nvim_create_user_command(
		"Pnpm",
		[[lua require("parsers.pnpm").parse()]],
		{ desc = "Parse pnpm output to quickfix list." }
	),
}
