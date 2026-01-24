local function setupKeymaps(gitsigns)
	-- Navigation
	vim.keymap.set("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "Jump to next git [c]hange" })

	vim.keymap.set("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "Jump to previous git [c]hange" })

	-- Actions
	vim.keymap.set("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "stage git hunk" })
	vim.keymap.set("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "reset git hunk" })

	vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
	vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
	vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })

	vim.keymap.set("n", "<leader>Tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
end

return {
	setup = setupKeymaps,
}
