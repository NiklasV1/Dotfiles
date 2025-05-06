return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		local colorizer = require("colorizer")

		colorizer.setup({
			css = { css = true, mode = "background" },
			scss = { css = true, mode = "background" },
			lua = { css = false, mode = "background" },
		})

		local command_group = vim.api.nvim_create_augroup("colorizer", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			pattern = { "*.css", "*.scss" },
			desc = "Refresh colorizer",
			group = command_group,
			callback = function()
				colorizer.reload_all_buffers()
			end,
		})
	end,
}
