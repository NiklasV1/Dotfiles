return {
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"NiklasV1/alabaster.nvim",
		lazy = false,
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.o.background = "light"
			vim.cmd.colorscheme("alabaster")
			vim.highlight.priorities.semantic_tokens = 90

			-- Disable semantic highlights
			--for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
			--	vim.api.nvim_set_hl(0, group, {})
			--end

			-- You can configure highlights by doing something like:
			vim.hl = vim.highlight
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
