return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      --Neotree keymap
      --vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal float<CR>')
      -- vim.keymap.set('n', '<M-n>', ':Neotree filesystem toggle reveal left')
      vim.keymap.set('n', '<leader>n', ':Neotree filesystem toggle reveal left')
    end
  }
}
