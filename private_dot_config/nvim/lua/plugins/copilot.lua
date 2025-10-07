return {
  "github/copilot.vim",
  config = function()
    -- Disable the default Tab mapping
    vim.g.copilot_no_tab_map = true
    vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    -- cycling through suggestions
    vim.keymap.set("i", "<C-]>", "copilot#Next()", { expr = true })
    vim.keymap.set("i", "<C-[>", "copilot#Previous()", { expr = true })
    -- Ensure Escape works properly
    vim.keymap.set("i", "<Esc>", "<Esc>", { noremap = true })
  end,
}
