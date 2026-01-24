local function setupKeymaps(builtin, borders)
	-- Help
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })

	-- File search
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Search open buffers" })

	-- Grep search
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })

	-- Diagnostics search
	vim.keymap.set("n", "<leader>se", function()
		builtin.diagnostics({
			severity = "Error",
		})
	end, { desc = "[S]earch [E]rrors" })

	-- Quickfix search
	vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "[S]earch [Q]uickfix" })

	-- Misc search
	vim.keymap.set("n", "<leader>sp", builtin.builtin, { desc = "[S]earch [P]ickers" })
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

	-- Current buffer fuzzy search
	vim.keymap.set("n", "<leader>/", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			border = true,
			borderchars = { prompt = borders.default, results = borders.alt },
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

	-- Search methods
	vim.keymap.set("n", "<leader>sm", function()
		require("telescope.builtin").lsp_document_symbols({ symbols = "method" })
	end, { desc = "[S]earch [M]ethods" })
end

return {
	setup = setupKeymaps,
}
