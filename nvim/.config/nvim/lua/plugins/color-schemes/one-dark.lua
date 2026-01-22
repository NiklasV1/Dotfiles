return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		vim.cmd.colorscheme("onedark")
		require("lualine").setup({ options = { theme = "onedark" } })
		-- vim.highlight.priorities.semantic_tokens = 90

		-- Disable semantic highlights
		--for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
		--	vim.api.nvim_set_hl(0, group, {})
		--end

		-- You can configure highlights by doing something like:
		-- vim.hl = vim.highlight
	end,
}
