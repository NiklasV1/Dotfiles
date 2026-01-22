require("lazy").setup({
	rocks = {
		hererocks = true,
	},

	-- Treesitter | AST
	require("core.plugins.treesitter"),

	-- Telescope | Navigation
	require("core.plugins.telescope"),

	-- LSP Config
	require("core.plugins.lspconfig"),

	-- Autocompletion
	require("core.plugins.cmp"),

	-- Auto close brackets
	-- TODO: Maybe not needed
	-- require("core.plugins.autopairs"),

	-- Formatting setup
	require("core.plugins.conform"),

	-- Auto detect indentation rules
	-- TODO: Maybe not needed
	-- require("core.plugins.vim-sleuth"),

	-- Lazy-Git integration
	require("core.plugins.lazygit"),

	-- Auto close HTML/XML tags
	require("extra.plugins.ts-autotag"),

	-- Grapple
	require("extra.plugins.grapple"),

	-- Treesitter textobjects
	require("extra.plugins.treesitter-textobjects"),

	-- Leap
	require("extra.plugins.leap"),

	-- Color scheme
	-- require("visuals.plugins.color-schemes.github"),
	-- require("visuals.plugins.color-schemes.modus"),
	-- require("visuals.plugins.color-schemes.melange"),
	-- require("visuals.plugins.color-schemes.alabaster"),
	-- require("visuals.plugins.color-schemes.sonokai"),
	-- require("visuals.plugins.color-schemes.oh-lucy"),
	-- require("visuals.plugins.color-schemes.one-dark"),

	-- Status Line
	-- TODO: Maybe not needed
	-- require("visuals.plugins.lualine"),

	-- Git change signs
	require("visuals.plugins.gitsigns"),

	-- Indentation lines
	require("visuals.plugins.indent_line"),

	-- Todo comments and notes highlighting
	require("visuals.plugins.todo-comments"),

	-- Keymap helper window
	require("visuals.plugins.which-key"),

	-- Filetree
	require("visuals.plugins.neo-tree"),
}, {})
