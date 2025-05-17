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
        lspconfig.lua_ls.setup({})
      end,
    }
  }
