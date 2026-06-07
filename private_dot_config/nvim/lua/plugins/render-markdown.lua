return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    -- Renders markdown in-buffer (headings, code blocks, tables, lists,
    -- checkboxes). On by default for markdown files in normal mode; shows
    -- raw source in insert mode so editing stays sane.
    opts = {},
    keys = {
      { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown: toggle render" },
    },
  },
}
