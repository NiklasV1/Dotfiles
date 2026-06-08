-- local COMMON_FORMATTERS = { "oxfmt", "prettierd", "prettier", stop_after_first = true }
local COMMON_FORMATTERS = { "prettierd", "prettier", stop_after_first = true }

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
			typescript = COMMON_FORMATTERS,
			css = COMMON_FORMATTERS,
			scss = COMMON_FORMATTERS,
			html = COMMON_FORMATTERS,
			htmlangular = COMMON_FORMATTERS,
			python = { "autopep8" },
			json = { "jq" },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			javascript = COMMON_FORMATTERS,
			sql = { "sql-formatter" },
			nix = { "nixfmt" },
		},
	},
}
