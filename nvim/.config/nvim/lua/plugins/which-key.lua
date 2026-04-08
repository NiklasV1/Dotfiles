local icons = {
	mappings = false,
	keys = {
		Up = "<Up> ",
		Down = "<Down> ",
		Left = "<Left> ",
		Right = "<Right> ",
		C = "<C-…> ",
		M = "<M-…> ",
		D = "<D-…> ",
		S = "<S-…> ",
		CR = "<CR> ",
		Esc = "<Esc> ",
		ScrollWheelDown = "<ScrollWheelDown> ",
		ScrollWheelUp = "<ScrollWheelUp> ",
		NL = "<NL> ",
		BS = "<BS> ",
		Space = "<Space> ",
		Tab = "<Tab> ",
		F1 = "<F1>",
		F2 = "<F2>",
		F3 = "<F3>",
		F4 = "<F4>",
		F5 = "<F5>",
		F6 = "<F6>",
		F7 = "<F7>",
		F8 = "<F8>",
		F9 = "<F9>",
		F10 = "<F10>",
		F11 = "<F11>",
		F12 = "<F12>",
	},
}

return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		delay = 0,
		win = {
			border = "rounded",
		},
		icons = icons,
		spec = {
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>g", group = "[G]rapple" },
			{ "<leader>q", group = "[Q]quickfix list" },
			{ "<leader>a", group = "[A]ngular" },
			{ "<leader>j", group = "[J]est" },
			{ "<leader>r", group = "[R]ush" },
			{ "<leader>rx", group = "[R]ush[X]" },
			-- Maybe remove these:
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>T", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			{ "<leader>l", group = "[L]azy Git" },
			{ "<leader>y", group = "[Y]ank" },
		},
	},
}

-- PLAN:
-- Search
-- Grapple
-- Quickfix
-- Git

-- Angular -- Maybe combine these three to a "Tool" group?
-- Jest
-- Rush
