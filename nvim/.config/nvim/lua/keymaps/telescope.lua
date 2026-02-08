local function setupKeymaps(builtin, borders)
	-- Help
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })

	-- Misc search
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

	-- Search methods
	vim.keymap.set("n", "<leader>sm", function()
		require("telescope.builtin").lsp_document_symbols({ symbols = "method" })
	end, { desc = "[S]earch [M]ethods" })
end

return {
	setup = setupKeymaps,
}
