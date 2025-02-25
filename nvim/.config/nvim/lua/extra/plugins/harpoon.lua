return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		-- Add to list
		vim.keymap.set("n", "<leader>ga", function()
			harpoon:list():add()
		end, { desc = "[G]o [A]dd" })

		-- Open list
		vim.keymap.set("n", "<leader>go", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[G]o [O]pen" })

		-- Go to buffer
		vim.keymap.set("n", "<leader>g1", function()
			harpoon:list():select(1)
		end, { desc = "[G]o [1]" })
		vim.keymap.set("n", "<leader>g2", function()
			harpoon:list():select(2)
		end, { desc = "[G]o [2]" })
		vim.keymap.set("n", "<leader>g3", function()
			harpoon:list():select(3)
		end, { desc = "[G]o [3]" })
		vim.keymap.set("n", "<leader>g4", function()
			harpoon:list():select(4)
		end, { desc = "[G]o [4]" })
		vim.keymap.set("n", "<leader>g5", function()
			harpoon:list():select(5)
		end, { desc = "[G]o [5]" })

		-- Previous/Next
		vim.keymap.set("n", "<leader>gn", function()
			harpoon:list():next()
		end, { desc = "[G]o [N]ext" })
		vim.keymap.set("n", "<leader>gp", function()
			harpoon:list():prev()
		end, { desc = "[G]o [P]revious" })
	end,
}
