local prettier = "prettierd"

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 2000,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { prettier, stop_after_first = true },
			css = { prettier, stop_after_first = true },
			scss = { prettier, stop_after_first = true },
			html = { prettier, stop_after_first = true },
			htmlangular = { prettier, stop_after_first = true },
			python = { "autopep8" },
			json = { "jq" },
			markdown = { "prettier", stop_after_first = true },
			javascript = { prettier, stop_after_first = true },
			sql = { "sql-formatter" },
		},
	},
}
