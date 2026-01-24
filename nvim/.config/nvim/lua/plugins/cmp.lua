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

				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
					vim.keymap.set({ "i", "s" }, "<C-N>", function()
						if luasnip.choice_active() then
							luasnip.change_choice(1)
						end
					end, { silent = true }),
					vim.keymap.set({ "i", "s" }, "<C-P>", function()
						if luasnip.choice_active() then
							luasnip.change_choice(-1)
						end
					end, { silent = true }),
				}),
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
