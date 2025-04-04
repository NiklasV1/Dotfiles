return {
	"joe-re/sql-language-server",
	config = function()
		require("lspconfig").sqlls.setup({
			on_attach = function(client, bufnr)
				require("sqls").on_attach(client, bufnr)
			end,
		})
	end,
}
