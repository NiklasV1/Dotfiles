local function luaSnipBuildStep()
	if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
		return
	end
	return "make install_jsregexp"
end

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = luaSnipBuildStep() },
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			-- Load snippets
			require("snippets")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				window = {
					completion = { border = "single", winhighlight = "Normal:CmpNormal", scrollbar = false },
					documentation = { border = "single" },
				},
				mapping = cmp.mapping.preset.insert(require("keymaps.cmp").setup(cmp, luasnip)),
				sources = {
					{ name = "lazydev", group_index = 0 },
					{ name = "luasnip", group_index = 1 },
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "nvim_lsp_signature_help", group_index = 1 },
					{ name = "path", group_index = 1 },
					{ name = "buffer", group_index = 1 },
				},
			})
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
