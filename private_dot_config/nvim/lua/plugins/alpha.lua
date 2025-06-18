return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local icons = require("nvim-web-devicons")


    -- Get specific icons
    local git_icon = icons.get_icon(".git", "git", { default = true })
    local config_icon = icons.get_icon("init.lua", "lua", { default = true })
    local shell_icon = icons.get_icon(".zshrc", "zsh", { default = true })

    dashboard.section.header.val = {
      [[                                                                                                                                               ]],
      [[                                                                                                                                               ]],
      [[                                                                                                                                               ]],
      [[                                                                                                                                               ]],
      [[                                                                                                                                             ]],
      [[                                            ████ ██████           █████      ██                                                        ]],
      [[                                           ███████████             █████                                                                ]],
      [[                                           █████████ ███████████████████ ███   ███████████                                      ]],
      [[                                          █████████  ███    █████████████ █████ ██████████████                                      ]],
      [[                                         █████████ ██████████ █████████ █████ █████ ████ █████                                      ]],
      [[                                       ███████████ ███    ███ █████████ █████ █████ ████ █████                                     ]],
      [[                                      ██████  █████████████████████ ████ █████ █████ ████ ██████                                    ]],
      [[                                                                                                                                               ]],
      [[                                                                                                                                               ]],
      [[         ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓███████▓▒░▒▓████████▓▒░       ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░       ░▒▓█▓▒░▒▓████████▓▒░   ]],
      [[         ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░          ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░       ]], 
      [[         ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░          ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░       ]], 
      [[         ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░   ░▒▓█▓▒░           ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░       ]], 
      [[  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░                 ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░       ]], 
      [[  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░                 ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░       ]], 
      [[   ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░   ░▒▓█▓▒░          ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░ ░▒▓██████▓▒░       ░▒▓█▓▒░  ░▒▓█▓▒░       ]], 
      [[                                                                                                                                               ]],
      [[                                                                                                                                               ]],
      }                                                                                                                                                
   -- Add custom bookmarks to dashboard
    dashboard.section.buttons.val = {
      dashboard.button("c", "🔧 Neovim config", "<cmd>cd ~/.config/nvim/ <cr>"),
      dashboard.button("C", "📁 Dotfiles config", "<cmd>cd ~/.config/ <cr>"),
      dashboard.button("g", "🐱 Git", "<cmd>cd ~/git/<cr>"),
      dashboard.button("r", "🗃️ Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("z", "🐚 .zshrc", "<cmd>e ~/.zshrc <cr>"),
      dashboard.button("t", "🖥️ .tmux.conf ", "<cmd>e ~/.tmux.conf<cr>"),
      dashboard.button("G", "👻 Ghostty config ", "<cmd>e ~/.config/ghostty/config<cr>"),
      dashboard.button("q", "❌ Quit", ":qa<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
}
