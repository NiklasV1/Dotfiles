-- For configs see: https://github.com/neovim/nvim-lspconfig/tree/master/lsp

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
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
				angularls = {
					cmd = angularls_new_cmd,
					filetypes = { "typescript", "html", "htmlangular", "htmldjango" },
					root_dir = not_in_backend,
					on_new_config = function(new_config, _)
						new_config.cmd = angularls_new_cmd
					end,
				},
			}

			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Lua
					"lua_ls",
					"stylua",

					-- Web dev
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"eslint",
					"prettierd",

					-- Misc
					"typos_lsp",
					"gopls",
					"pyright",
					"bashls",
				},
			})

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
