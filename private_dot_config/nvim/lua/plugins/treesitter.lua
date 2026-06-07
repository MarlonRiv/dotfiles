return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = false,
        ensure_installed = {

          "bash",
          "cpp",
          "c",
          "python",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
        },
        highlight = { enable = true },
        indent = { enable = false },
        -- fold = { enable = true },

      })
    end
  }
}
