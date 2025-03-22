return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		-- Setup theme
		require("github-theme").setup({
			options = {
				darken = {
					floats = false,
					sidebars = {
						enable = false,
					},
				},
			},
			palettes = {
				all = {
					fg = {
						default = "#000000",
					},
					border = {
						default = "#000000",
					},
				},
			},
		})

		vim.cmd("colorscheme github_light_default")
	end,
}
