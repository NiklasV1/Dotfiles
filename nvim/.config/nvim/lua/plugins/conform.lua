local prettier = "prettier"

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Why is htmlangular disabled?
			local disable_filetypes = { c = true, cpp = true, sql = true, htmlangular = true, htmldjango = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 2000,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { prettier, stop_after_first = true },
			css = { prettier, stop_after_first = true },
			scss = { prettier, stop_after_first = true },
			html = { prettier, stop_after_first = true },
			htmlangular = { prettier, stop_after_first = true },
			python = { "autopep8" },
			json = { "jq" },
			markdown = { prettier, stop_after_first = true },
			javascript = { prettier, stop_after_first = true },
			sql = { "sql-formatter" },
		},
	},
}
