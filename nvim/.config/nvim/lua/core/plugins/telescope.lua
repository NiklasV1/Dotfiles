return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`

			-- Change color of file paths
			vim.api.nvim_create_autocmd("Filetype", {
				pattern = "TelescopeResults",
				callback = function(ctx)
					vim.api.nvim_buf_call(ctx.buf, function()
						vim.fn.matchadd("TelescopeFullFilePath", [[\t\t|\t\t\zs.*\ze\t\t]])
						vim.api.nvim_set_hl(0, "TelescopeFullFilePath", { link = "Comment" })
					end)
				end,
			})

			-- Override function for path_display
			local function filenameFirst(_, path)
				local tail = require("telescope.utils").path_tail(path)
				return string.format("%s\t\t|\t\t%s\t\t", tail, path)
			end

			-- Default border settings
			local borderSettings = {
				prompt = { 1, 1, 1, 1 },
				results = { 1, 1, 1, 1 },
				preview = { 1, 1, 1, 1 },
			}

			-- Default border characters settings
			local borderChars = {
				prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			}

			-- Alternative border characters settings
			local alternativeBorderChars = {
				prompt = borderChars.prompt,
				results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
				preview = borderChars.preview,
			}

			-- Additional key mappings
			local keymaps = {}

			require("telescope").setup({
				-- Default settings
				defaults = {
					border = borderSettings,
					borderchars = borderChars,
					-- cache_picker = {
					-- 	num_pickers = 5,
					-- },
					mappings = {
						i = keymaps,
						n = keymaps,
					},
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							height = 0.9,
							width = 0.8,
							prompt_position = "bottom",
							preview_cutoff = 40,
							scroll_speed = 2,
						},
					},
					path_display = filenameFirst,
				},
				-- Overrides for individual pickers
				pickers = {
					buffers = {
						mappings = {
							i = {
								["<C-d>"] = "delete_buffer",
							},
							n = {
								["<C-d>"] = "delete_buffer",
							},
						},
						sort_mru = true,
						disable_coordinates = true,
					},
					jumplist = {
						path_display = function(_, path)
							return require("telescope.utils").path_tail(path)
						end,
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
				},
				-- Extensions
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
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

			-- Quickfix search
			vim.keymap.set("n", "<leader>qs", builtin.quickfix, { desc = "[Q]uickfix [S]earch" })
			vim.keymap.set("n", "<leader>qh", builtin.quickfixhistory, { desc = "[Q]uickfix [H]istory" })

			-- Misc search
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

			-- TODO: Terminal search
			-- vim.keymap.set("n", "<leader>st", function()
			-- 	builtin.buffers(require("telescope.themes").get_dropdown({
			-- 		border = border,
			-- 		borderchars = alternativeBorderChars,
			-- 		previewer = false,
			-- 	}))
			-- end, { desc = "[S]earch [T]erminals" })

			-- Current buffer fuzzy search
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					border = borderSettings,
					borderchars = alternativeBorderChars,
					previewer = false,
					layout_config = {
						center = {
							width = 0.6,
							height = 0.5,
						},
					},
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- Open files live grep
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- NeoVim config file search
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
