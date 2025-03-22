return {
	"sainnhe/sonokai",
	name = "atlantic",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		vim.g.sonokai_style = "atlantic"
		-- vim.g.sonokai_enable_italic = 1
		vim.g.sonokai_better_performance = 1
		vim.cmd("colorscheme sonokai")
		require("lualine").setup({ options = { theme = "sonokai" } })
	end,
}
