require("lazy").setup({
	rocks = {
		hererocks = true,
	},

	-- Treesitter | AST
	require("plugins.treesitter"),

	-- Telescope | Navigation
	require("plugins.telescope"),

	-- Telescope | Navigation
	require("plugins.fff"),

	-- LSP Config
	require("plugins.lspconfig"),

	-- Autocompletion
	require("plugins.cmp"),

	-- Improved LSP capavilities
	require("plugins.cmp-nvim-lsp"),

	-- Auto close brackets
	require("plugins.autopairs"),

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

	-- Git signs
	require("plugins.gitsigns"),

	-- Keymap helper window
	require("plugins.which-key"),

	-- Filetree
	require("plugins.neo-tree"),

	-- {
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	config = function()
	-- 		require("colorizer").setup()
	-- 	end,
	-- },
}, {})
