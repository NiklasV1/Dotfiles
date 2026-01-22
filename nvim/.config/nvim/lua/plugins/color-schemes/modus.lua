return {
	"miikanissi/modus-themes.nvim",
	lazy = false,
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.o.background = "light"
		vim.cmd.colorscheme("modus")
		-- vim.highlight.priorities.semantic_tokens = 90

		-- Disable semantic highlights
		--for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
		--	vim.api.nvim_set_hl(0, group, {})
		--end

		-- You can configure highlights by doing something like:
		-- vim.hl = vim.highlight
	end,
}
