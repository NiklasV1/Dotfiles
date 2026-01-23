-- Keymaps
local keymaps = {
	refine = { ["<C-Space>"] = "to_fuzzy_refine" }, -- Refine search results
	buffers = { ["<C-d>"] = "delete_buffer" }, -- Delete buffer
}

-- Border characters
local border = {
	default = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	alt = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
}

-- File paths behind file names
local function filenameFirst(_, path)
	local tail = require("telescope.utils").path_tail(path)
	return string.format("%s\t\t|\t\t%s\t\t", tail, path)
end

-- File path color
local function setupFilePathColoring()
	local telescopeAutoCommandGroup = vim.api.nvim_create_augroup("telescopeAutoCommandGroup", { clear = true })
	vim.api.nvim_create_autocmd("Filetype", {
		pattern = "TelescopeResults",
		group = telescopeAutoCommandGroup,
		callback = function(ctx)
			vim.api.nvim_buf_call(ctx.buf, function()
				vim.fn.clearmatches()
				vim.fn.matchadd("TelescopeFullFilePath", [[\t\t|\t\t\zs.*\ze\t\t]])
			end)
		end,
	})
	vim.api.nvim_set_hl(0, "TelescopeFullFilePath", { link = "Comment" })
end

-- Basic settings
local basicSettings = {
	border = true,
	borderchars = border.default,
	mappings = {
		i = keymaps.refine,
		n = keymaps.refine,
	},
	layout_strategy = "vertical",
	layout_config = {
		vertical = {
			height = 0.9,
			width = 0.8,
			prompt_position = "bottom",
			preview_cutoff = 20,
			scroll_speed = 2,
		},
	},
	path_display = filenameFirst,
}

-- Picker settings
local pickerSettings = {
	buffers = {
		mappings = {
			i = keymaps.buffers,
			n = keymaps.buffers,
		},
		sort_mru = true,
		disable_coordinates = true,
	},
	live_grep = {
		disable_coordinates = true,
	},
	grep_string = {
		disable_coordinates = true,
	},
	quickfix = {
		fname_width = 98,
		path_display = "absolute",
	},
	lsp_document_symbols = {
		symbol_width = 50,
		symbol_type_width = 16,
	},
}

-- Extension settings
local extensionSettings = {
	["ui-select"] = {
		require("telescope.themes").get_dropdown(),
	},
}

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- 10x fzf speedup | requires make
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- Icons for filetypes
	},
	config = function()
		-- Change color of file paths
		setupFilePathColoring()

		-- Setup telescope
		require("telescope").setup({
			defaults = basicSettings,
			pickers = pickerSettings,
			extensions = extensionSettings,
		})

		-- Load extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		-- Help
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

		-- File search
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		-- Grep search
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })

		-- Jumplist search
		vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]ump List" })

		-- Paste/Register search
		vim.keymap.set("n", "<leader>pr", builtin.registers, { desc = "[P]aste [R]egister" })

		-- Diagnostics search
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>se", function()
			builtin.diagnostics({
				severity = "Error",
			})
		end, { desc = "[S]earch [E]rrors" })

		-- Quickfix search
		vim.keymap.set("n", "<leader>qs", builtin.quickfix, { desc = "[Q]uickfix [S]earch" })
		vim.keymap.set("n", "<leader>qh", builtin.quickfixhistory, { desc = "[Q]uickfix [H]istory" })

		-- Misc search
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

		-- Current buffer fuzzy search
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				border = true,
				borderchars = { prompt = border.default, results = border.alt },
				previewer = false,
				layout_config = {
					center = {
						width = 0.6,
						height = 0.5,
					},
				},
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Search open files
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Search neovim config
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
