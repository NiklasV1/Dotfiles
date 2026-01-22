require("lazy").setup({
	rocks = {
		hererocks = true,
	},

	-- Core functionality
	require("core.plugins"),

	-- Extra functionality
	require("extra.plugins"),

	-- Visual plugins
	require("visuals.plugins"),
}, {})
