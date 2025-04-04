return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"haydenmeade/neotest-jest",
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run Current Test",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run Last Test",
			},
			{
				"<leader>tw",
				"<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
				desc = "Run Watch",
			},
		},
		opts = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
	},
}
