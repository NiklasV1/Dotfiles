return {
	-- Treesitter | AST
	require("core.plugins.treesitter"),

	-- Telescope | Navigation
	require("core.plugins.telescope"),

	-- LSP Config
	require("core.plugins.lspconfig"),

	-- Autocompletion
	require("core.plugins.cmp"),

	-- Auto close brackets
	require("core.plugins.autopairs"),

	-- Formatting setup
	require("core.plugins.conform"),

	-- Linter
	require("core.plugins.lint"),

	-- Better text objects
	require("core.plugins.mini"),

	-- Auto detect indentation rules
	require("core.plugins.vim-sleuth"),

	-- Lazy-Git integration
	require("core.plugins.lazygit"),
}
