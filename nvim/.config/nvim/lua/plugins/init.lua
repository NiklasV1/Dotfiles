require("lazy").setup({
	rocks = {
		hererocks = true,
	},

	-- Treesitter | AST
	require("plugins.treesitter"),

	-- Telescope | Navigation
	require("plugins.telescope"),

	-- LSP Config
	require("plugins.lspconfig"),

	-- Autocompletion
	require("plugins.cmp"),

	-- Auto close brackets
	-- TODO: Maybe not needed
	-- require("plugins.autopairs"),

	-- Formatting setup
	require("plugins.conform"),

	-- Grapple
	require("plugins.grapple"),

	-- Lazy-Git integration
	require("plugins.lazygit"),

	-- Auto close HTML/XML tags
	require("plugins.ts-autotag"),

	-- Treesitter textobjects
	require("plugins.treesitter-textobjects"),

	-- Leap
	require("plugins.leap"),

	-- Color scheme
	-- require("plugins.color-schemes.github"),

	-- Status Line
	-- TODO: Maybe not needed
	-- require("plugins.lualine"),

	-- Git change signs
	require("plugins.gitsigns"),

	-- Indentation lines
	require("plugins.indent_line"),

	-- Todo comments and notes highlighting
	require("plugins.todo-comments"),

	-- Keymap helper window
	require("plugins.which-key"),

	-- Filetree
	require("plugins.neo-tree"),
}, {})
