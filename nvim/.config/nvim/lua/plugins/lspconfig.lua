-- For configs see: https://github.com/neovim/nvim-lspconfig/tree/master/lsp

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client.supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			vim.diagnostic.config({
				signs = true,
				underline = true,
				severity_sort = true,
				update_in_insert = false,
				float = {
					scope = "line",
					source = "if_many",
					border = "single",
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- TODO: find out if this still works
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local home = vim.env.HOME
			local languageServerPath = home
				.. "/.nvm/versions/node/v22.14.0/lib/node_modules/@angular/language-server/bin/ngserver"
			local typescriptPath = home .. "/.nvm/versions/node/v22.14.0/lib/node_modules/typescript/lib"
			local angularLanguageServicePath = home
				.. "/.nvm/versions/node/v22.14.0/lib/node_modules/@angular/language-service"
			local angularls_new_cmd = {
				languageServerPath,
				"--stdio",
				"--tsProbeLocations",
				typescriptPath,
				"--ngProbeLocations",
				angularLanguageServicePath,
				"--forceStrictTemplates",
			}

			local function ignore_on_backend_dir(filename)
				-- Don't attach to files in snapaddy-backend directory
				if string.match(filename, "snapaddy%-backend") then
					return nil
				end
				-- Use default root_dir logic for angularls
				return vim.fs.dirname(vim.fs.find("package.json", { path = filename, upward = true })[1])
					or vim.fs.dirname(vim.fs.find("node_modules", { path = filename, upward = true })[1])
					or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
			end

			local function not_in_backend(bufnr, on_dir)
				local filename = vim.api.nvim_buf_get_name(bufnr)

				local root = ignore_on_backend_dir(filename)

				if root then
					on_dir(root)
				end

				-- Do not call on_dir if root is nil to prevent the client from attaching to the buffer
			end

			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				-- ts_ls = {},
				--
				gopls = {},
				pyright = {},
				html = {
					-- capabilities = capabilities,
					filetypes = { "html", "htmlangular", "htmldjango" },
				},
				ts_ls = {
					-- Disabled for now
					-- filetypes = {},
					-- capabilities = capabilities,
					init_options = {
						preferences = {
							importModuleSpecifierPreference = "relative",
							importModuleSpecifierEnding = "minimal",
						},
					},
				},
				angularls = {
					-- capabilities = capabilities,
					cmd = angularls_new_cmd,
					filetypes = { "typescript", "html", "htmlangular", "htmldjango" },
					root_dir = not_in_backend,
					on_new_config = function(new_config, _)
						new_config.cmd = angularls_new_cmd
					end,
				},
				-- tailwindcss = {
				-- 	filetypes = { "html", "htmlangular", "htmldjango" },
				-- 	root_dir = not_in_backend,
				-- },
				eslint = {
					-- capabilities = capabilities,
					filetypes = { "typescript", "html", "htmlangular", "htmldjango" },
				},
				cssls = {},
				bashls = {
					-- capabilities = capabilities,
					filetypes = { "bash", "sh", "zsh" },
				},
				typos_lsp = {
					init_options = {
						diagnosticSeverity = "Hint",
					},
				},
				-- tsgo = {
				-- 	init_options = {
				-- 		preferences = {
				-- 			importModuleSpecifierPreference = "relative",
				-- 			importModuleSpecifierEnding = "minimal",
				-- 		},
				-- 	},
				-- },
			}

			-- Auto-Install servers
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Setup server configs
			for server_name, server_config in pairs(servers) do
				vim.lsp.config(server_name, server_config)
			end

			-- Enable servers
			require("mason-lspconfig").setup()
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
