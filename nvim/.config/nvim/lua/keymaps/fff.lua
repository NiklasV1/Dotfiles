local keybinds = {}

keybinds.setup = function(fff)
	vim.keymap.set("n", "<leader>sf", fff.find_files, { desc = "[S]earch [F]iles" })

	vim.keymap.set("n", "<leader>sn", function()
		fff.find_files_in_dir(vim.fn.stdpath("config"))
	end, { desc = "[S]earch [N]eovim files" })

	vim.keymap.set("n", "<leader>sg", function()
		fff.live_grep()
	end, { desc = "[S]earch [G]rep" })
end

return keybinds
