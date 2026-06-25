-- TODO: Refactor to new format
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
			local base = vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("%:t:r")
			local scss_file = base .. ".scss"
			local css_file = base .. ".css"

			if vim.fn.filereadable(scss_file) == 1 then
				vim.cmd.edit(vim.fn.fnameescape(scss_file))
			else
				vim.cmd.edit(vim.fn.fnameescape(css_file))
			end
		end, { desc = "[A]ngular [S]tyle" })
	end,
})
