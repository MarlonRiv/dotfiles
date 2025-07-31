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
          "clangd", "pylsp", "lua_ls", "lemminx", "cmake",
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
          return ros_workspace
        end
      end

      -- === EXPLICIT SERVER CONFIGURATIONS ===
      -- These calls are now the ONLY source of LSP servers.
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--compile-commands-dir=" .. get_workspace_dir(),
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--fallback-style={ BasedOnStyle: LLVM, ColumnLimit: 160, IndentWidth: 2, TabWidth: 2, UseTab: Never, AccessModifierOffset: -1, PointerAlignment: Left, AlwaysBreakTemplateDeclarations: true, IndentCaseLabels: true, SortIncludes: false, AllowShortFunctionsOnASingleLine: None }",
        },
        root_dir = get_workspace_dir(),
      })

      lspconfig.pylsp.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { pylsp = { plugins = { pycodestyle = { ignore = { "W391" }, maxLineLength = 100 }, rope_completion = { enabled = true }, jedi_completion = { enabled = true, include_params = true } } } },
      })

      lspconfig.lemminx.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.cmake.setup({ capabilities = capabilities, on_attach = on_attach })

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
