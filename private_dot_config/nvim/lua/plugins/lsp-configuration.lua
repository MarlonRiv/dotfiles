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
			local lspconfig = require("lspconfig")

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

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.cmake.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})
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
