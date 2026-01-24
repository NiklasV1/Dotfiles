local function setupKeymaps(cmp, luasnip)
	return {
		-- Completion keymaps
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-Space>"] = cmp.mapping.complete({}),

		-- Snippet keymaps
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
	}
end

return {
	setup = setupKeymaps,
}
