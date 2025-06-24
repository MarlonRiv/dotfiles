return {
  "voldikss/vim-floaterm",
  event = "VeryLazy",
  config = function()
    -- Floaterm settings
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_position = 'center'
    vim.g.floaterm_opener = 'tabe' -- Open files in new tabs
  end,
  keys = {
    -- Specific applications
    { "<leader>lg", "<cmd>FloatermNew --name=lazygit lazygit<cr>", desc = "LazyGit" },
    {
      "<leader>inv",
      '<cmd>FloatermNew --name=inv --autoclose=2 fzf --preview="bat --color=always {}"<cr>',
      desc = "Interactive File Selection with FZF",
    },
    -- Terminal management
    { "<leader>o",  "<cmd>FloatermToggle<cr>",                     desc = "Toggle Terminal" },
    { "<leader>tn", "<cmd>FloatermNew<cr>",                        desc = "New Terminal" },
    { "<leader>tk", "<cmd>FloatermKill<cr>",                       desc = "Kill Terminal" },
  },
}
