return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "master",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = require("keymaps.treesitter-textobjects"),
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "V",
					},
				},
			},
		})
	end,
}
