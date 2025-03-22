return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			css = { css = true, mode = "background" },
			scss = { css = true, mode = "background" },
		})
	end,
}
