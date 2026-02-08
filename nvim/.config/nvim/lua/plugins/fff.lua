return {
	-- fff.nvim is super fast and has minimal passive performance penalty
	{
		"dmtrKovalenko/fff.nvim",
		build = function()
			require("fff.download").download_or_build_binary()
		end,
		lazy = false,
		config = function()
			local fff = require("fff")
			fff.setup({
				base_path = vim.fn.getcwd(),
				prompt = "> ",
				title = "Files",
				max_threads = 8,
				layout = {
					prompt_position = "bottom",
					preview_position = "top",
				},
			})

			-- Keymaps
			require("keymaps.fff").setup(fff)
		end,
	},
}
