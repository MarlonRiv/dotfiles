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
        },
        highlight = { enable = true },
        indent = { enable = false },
      })
    end
  }
}
