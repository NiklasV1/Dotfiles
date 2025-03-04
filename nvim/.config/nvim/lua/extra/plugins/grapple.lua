return {
	"cbochs/grapple.nvim",
	opts = {
		scope = "git_branch", -- also try out "git_branch"
		icons = false, -- setting to "true" requires "nvim-web-devicons"
		status = false,
	},
	keys = {
		{ "<leader>ga", "<cmd>Grapple toggle<cr>", desc = "[G]rapple [A]dd" },
		{ "<leader>go", "<cmd>Grapple toggle_tags<cr>", desc = "[G]rapple [O]pen" },

		{ "<leader>g1", "<cmd>Grapple select index=1<cr>", desc = "[G]rapple [1]" },
		{ "<leader>g2", "<cmd>Grapple select index=2<cr>", desc = "[G]rapple [2]" },
		{ "<leader>g3", "<cmd>Grapple select index=3<cr>", desc = "[G]rapple [3]" },
		{ "<leader>g4", "<cmd>Grapple select index=4<cr>", desc = "[G]rapple [4]" },
		{ "<leader>g5", "<cmd>Grapple select index=5<cr>", desc = "[G]rapple [5]" },

		{ "<leader>gn", "<cmd>Grapple cycle_tags next<cr>", desc = "[G]rapple [N]ext" },
		{ "<leader>gp", "<cmd>Grapple cycle_tags prev<cr>", desc = "[G]rapple [P]revious" },
	},
}
