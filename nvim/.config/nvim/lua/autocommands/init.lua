-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("userHighlightYankGroup", { clear = true }),
	callback = function()
		if vim.v.event.operator == "y" then
			vim.highlight.on_yank()
		end
	end,
})

-- Highlight symbol under cursor
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("userLspAttachGroup", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if
			client
			and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlightAutogroup = vim.api.nvim_create_augroup("userLspReferenceHighlight", { clear = true })

			-- Highlight on hold
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlightAutogroup,
				callback = vim.lsp.buf.document_highlight,
			})

			-- Clear on move
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlightAutogroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- Clear autocommands on detach
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("userLspDetachGroup", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "userLspReferenceHighlight", buffer = event2.buf })
				end,
			})
		end
	end,
})
