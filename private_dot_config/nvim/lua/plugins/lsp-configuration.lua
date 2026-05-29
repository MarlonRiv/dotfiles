return {
	-- 1. Mason: Installs the tools.
	{
		"williamboman/mason.nvim",
		config = true,
	},

	-- 2. Mason-LSPConfig: The bridge, now told to do nothing but install.
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"pylsp",
					"lua_ls",
					"lemminx",
					"cmake",
					"rust_analyzer",
				},
				automatic_enable = false,
				handlers = {},
			})
		end,
	},

	-- 3. Nvim-LSPConfig: The command center. This is where all setup happens.
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			end

			local function get_workspace_dir()
				local ros_workspace = vim.env.ROS_WORKSPACE
				if ros_workspace and vim.fn.isdirectory(ros_workspace) == 1 then
          --log out if we are using a ROS workspace 
          print("Using ROS workspace: " .. ros_workspace)
					return ros_workspace
				end
			end

			-- === EXPLICIT SERVER CONFIGURATIONS ===
			-- These calls are now the ONLY source of LSP servers.
			local workspace_dir = get_workspace_dir()
			local clangd_cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
        "--log=verbose",
        -- "--fallback-style=LLVM",
				-- "--fallback-style={ BasedOnStyle: LLVM, ColumnLimit: 160, IndentWidth: 2, TabWidth: 2, UseTab: Never, AccessModifierOffset: -1, PointerAlignment: Left, AlwaysBreakTemplateDeclarations: true, IndentCaseLabels: true, SortIncludes: false, AllowShortFunctionsOnASingleLine: None }",
			}
			if workspace_dir then
				table.insert(clangd_cmd, "--compile-commands-dir=" .. workspace_dir)
			end

			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				cmd = clangd_cmd, -- use the correct variable here!
				root_dir = workspace_dir, -- optional, if you want root_dir set
			})

			lspconfig.pylsp.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = { ignore = { "W391" }, maxLineLength = 100 },
							rope_completion = { enabled = true },
							jedi_completion = { enabled = true, include_params = true },
						},
					},
				},
			})

			lspconfig.lemminx.setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.cmake.setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.yamlls.setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.jinja_lsp.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })

			-- Harper LSP basic setup
			lspconfig.harper_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "markdown", "text", "gitcommit" },
				settings = {
					["harper-ls"] = {

						-- Academic writing optimized linters
						linters = {
							-- Essential for academic writing
							spell_check = true,
							an_a = true,
							unclosed_quotes = true,
							spaces = true,
							matcher = true,
							correct_number_suffix = true,

							-- Academic style preferences
							spelled_numbers = false, -- Allow "1st", "2nd", "3rd" etc.
							sentence_capitalization = true, -- Important for formal writing
							wrong_quotes = true, -- Enforce consistent quote style
							long_sentences = true, -- Flag overly complex sentences
							repeated_words = true,

							-- Advanced academic linters (if available)
							redundant_acronyms = true,
							multiple_sequential_pronouns = true, -- Improve readability
							linking_verbs = false, -- Too restrictive for academic writing
							avoid_curses = true,
							terminating_conjunctions = false, -- Common in academic conclusions
							missing_oxford_comma = true, -- Enforce Oxford comma for clarity

							-- Disable overly strict rules
							abbreviation_periods = false, -- Allow "e.g." without flagging
						},

            -- General writing settings (uncomment and adjust as needed)
						-- linters = {
						-- 	-- Basic grammar and spelling
						-- 	spell_check = true,
						-- 	spelled_numbers = false, -- Don't flag "1st", "2nd", etc.
						-- 	an_a = true,
						-- 	sentence_capitalization = false, -- Less strict for technical writing
						-- 	unclosed_quotes = true,
						-- 	wrong_quotes = false, -- Allow flexibility in quote styles
						--
						-- 	-- Sentence structure
						-- 	long_sentences = false, -- Often unavoidable in technical docs
						-- 	repeated_words = true,
						-- 	spaces = true,
						-- 	matcher = true,
						--
						-- 	-- Number and formatting
						-- 	correct_number_suffix = true,
						-- 	number_suffix_capitalization = true,
						--
						-- 	-- Advanced linters
						-- 	multiple_sequential_pronouns = false, -- Less relevant for tech docs
						-- 	linking_verbs = false, -- Too restrictive for technical writing
						-- 	avoid_curses = false, -- Personal preference
						-- 	terminating_conjunctions = false, -- Common in technical writing
						--
						-- 	-- Additional linters (if available)
						-- 	spell_check_dict = true,
						-- 	redundant_acronyms = true,
						-- 	missing_oxford_comma = false, -- Style preference
						-- },

						-- Academic writing settings
						codeActions = {
							forceStable = true, -- Prefer established suggestions for formal writing
						},

						-- LaTeX/Markdown specific
						markdown = {
							ignoreLinkTitle = true, -- Don't check citation links
						},

						-- Conservative diagnostic level for academic work
						diagnosticSeverity = "hint", -- Less intrusive during writing flow

						-- Language settings
						isolateEnglish = true, -- Better handling of mixed content
						dialect = "American", -- Change to "British" if needed

						-- Performance for long papers
						maxFileLength = 500000, -- Handle large documents
					},
				},
			})

			-- === GLOBAL LSP & DIAGNOSTIC CONFIGURATION ===
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
				float = { border = "rounded", source = "always", header = "", prefix = "", focusable = false },
			})

			vim.o.updatetime = 250

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end,
			})

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
		end,
	},
}
