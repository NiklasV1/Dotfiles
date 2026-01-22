-- Angular file switching
local angularCommandGroup = vim.api.nvim_create_augroup("angularCommandGroup", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "html", "typescript", "htmlangular", "css", "scss" },
	group = angularCommandGroup,
	desc = "Apply angular features to Angular files",
	callback = function()
		vim.keymap.set("n", "<leader>ac", function()
			vim.cmd([[edit %:h/%:t:r.ts]])
		end, { desc = "[A]ngular [C]omponent" })

		vim.keymap.set("n", "<leader>at", function()
			vim.cmd([[edit %:h/%:t:r.html]])
		end, { desc = "[A]ngular [T]emplate" })

		vim.keymap.set("n", "<leader>as", function()
			vim.cmd([[edit %:h/%:t:r.css]])
		end, { desc = "[A]ngular [S]tyle" })
	end,
})
