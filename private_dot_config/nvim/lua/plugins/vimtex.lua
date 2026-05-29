return {
  "lervag/vimtex",
  lazy = false, -- vimtex must load at startup
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
    -- Disable vimtex's default insert mode mappings if they conflict
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
  end,
}
