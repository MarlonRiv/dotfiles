return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- ROS

			-- ROS XML files (launch files, URDF, etc.)
			lspconfig.lemminx.setup({
				capabilities = capabilities,
				settings = {
					xml = {
						catalogs = {
							-- Add ROS XML schemas
							vim.fn.expand("~/.local/share/nvim/ros_schemas.xml"),
						},
						validation = {
							enabled = true,
						},
						completion = {
							autoCloseTags = true,
						},
					},
				},
			})

			-- Enhanced Python with ROS-specific configuration
			lspconfig.pylsp.setup({
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { "W391" },
								maxLineLength = 100,
							},
							rope_completion = {
								enabled = true,
							},
							jedi_completion = {
								enabled = true,
								include_params = true,
							},
							jedi_hover = {
								enabled = true,
							},
							jedi_references = {
								enabled = true,
							},
							jedi_signature_help = {
								enabled = true,
							},
							jedi_symbols = {
								enabled = true,
								all_scopes = true,
							},
						},
					},
				},
			})

			-- Enhanced C++ with ROS-specific configuration
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
					"--compile-commands-dir=build", -- Look for compile_commands.json in build dir
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
				root_dir = function(fname)
					-- Look for ROS workspace indicators
					local util = require("lspconfig.util")
					return util.root_pattern(
						"compile_commands.json",
						"compile_flags.txt",
						".git",
						"devel",
						"build",
						"install"
					)(fname) or util.path.dirname(fname)
				end,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			-- Configure diagnostics
			vim.diagnostic.config({
				virtual_text = false, -- Disable inline text to avoid clutter
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
					focusable = false,
				},
			})

			-- Set updatetime for faster CursorHold trigger
			vim.o.updatetime = 250

			-- Auto-show diagnostics on cursor hold
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end,
			})

			lspconfig.lua_ls.setup({})

			-- lspconfig.clangd.setup({
			-- 	capabilities = capabilities,
			-- })
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.cmake.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			-- lspconfig.yamlls.setup({
			-- 	capabilities = capabilities,
			-- })

			lspconfig.yamlls.setup({
				capabilities = capabilities,
				settings = {
					yaml = {
						schemas = {
							-- Add ROS parameter file schemas
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
						},
						validate = true,
						completion = true,
					},
				},
			})
			-- lspconfig.pylsp.setup({
			-- 	capabilities = capabilities,
			-- })
			-- LSP Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})

			-- Additional diagnostic keymaps
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
		end,
	},
}
