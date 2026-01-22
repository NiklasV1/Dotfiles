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

	-- Auto detect indentation rules
	-- TODO: Maybe not needed
	-- require("plugins.vim-sleuth"),

	-- Lazy-Git integration
	require("plugins.lazygit"),

	-- Auto close HTML/XML tags
	require("plugins.ts-autotag"),

	-- Grapple
	require("plugins.grapple"),

	-- Treesitter textobjects
	require("plugins.treesitter-textobjects"),

	-- Leap
	require("plugins.leap"),

	-- Color scheme
	-- require("plugins.color-schemes.github"),
	-- require("plugins.color-schemes.modus"),
	-- require("plugins.color-schemes.melange"),
	-- require("plugins.color-schemes.alabaster"),
	-- require("plugins.color-schemes.sonokai"),
	-- require("plugins.color-schemes.oh-lucy"),
	-- require("plugins.color-schemes.one-dark"),

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
