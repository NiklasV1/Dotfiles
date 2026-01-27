return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = require("keymaps.neo-tree"),
	opts = {
		close_if_last_window = false,
		window = {
			width = 84,
			position = "right",
			mappings = {
				["<F5>"] = "refresh",
				["\\"] = "close_window",
			},
		},
		filesystem = {
			filtered_items = {
				hide_gitignored = false,
				hide_dotfiles = false,
				always_show = {
					".gitignore",
				},
				always_show_by_pattern = {
					".env*",
				},
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
	},
	default_component_configs = {
		indent = {
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			indent_size = 2,
		},
	},
}
