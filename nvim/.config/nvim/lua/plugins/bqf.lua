return {
	"https://github.com/kevinhwang91/nvim-bqf",
	ft = "qf",
	dependencies = {
		{
			"junegunn/fzf",
			config = function()
				vim.fn["fzf#install"]()
			end,
		},
	},
	config = function()
		require("bqf").setup({
			func_map = {
				prevfile = "", -- disable buggy C-p
				nextfile = "", -- disable buggy C-n
			},
			preview = {
				winblend = 0, -- no transparency on preview window
				border = "single",
				win_height = 20,
			},
			filter = {
				fzf = {
					action_for = {
						["ctrl-x"] = { -- unbind default split binding
							description = "",
							default = "",
						},
						["ctrl-s"] = {
							description = "Press ctrl-s to open up the item in a new horizontal split",
							default = "split",
						},
					},
					extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│", "--color", "light" },
				},
			},
		})
	end,
}
