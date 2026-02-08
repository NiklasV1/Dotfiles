local U = {}

U.get_symbols = function(symbol_kind)
	local params = { textDocument = vim.lsp.util.make_text_document_params() }

	vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result, _, _)
		if err or not result then
			vim.print("No symbols found.")
			return
		end

		local items = {}
		local bufnr = vim.api.nvim_get_current_buf()

		local function handle_symbol(symbol)
			local range = symbol.selectionRange or symbol.range

			if symbol.kind == symbol_kind then
				table.insert(items, {
					bufnr = bufnr,
					lnum = range.start.line + 1,
					col = range.start.character + 1,
					text = symbol.name .. " [" .. symbol.kind .. "]",
				})
			end

			-- handle nested symbols (classes, methods, etc.)
			if symbol.children then
				for _, child in ipairs(symbol.children) do
					handle_symbol(child)
				end
			end
		end

		for _, symbol in ipairs(result) do
			handle_symbol(symbol)
		end

		vim.fn.setqflist({}, " ", {
			title = string.format("LSP Symbols [%s]", symbol_kind),
			items = items,
		})

		vim.cmd("bot copen")
	end)
end

return U
