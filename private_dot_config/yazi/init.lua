th.git = th.git or {}

-- GitHub-like colors
th.git.modified = ui.Style():fg("#f9e2af")        -- Yellow (soft pastel)
th.git.added = ui.Style():fg("#a6e3a1")          -- Green (soft pastel) 
th.git.untracked = ui.Style():fg("#89dceb")      -- Sky (soft pastel blue)
th.git.ignored = ui.Style():fg("#6c7086"):dim()  -- Overlay0 (muted gray)
th.git.deleted = ui.Style():fg("#f38ba8")        -- Red (soft pastel)
th.git.updated = ui.Style():fg("#cba6f7")        -- Mauve (soft pastel purple)

-- Single character symbols
th.git.modified_sign = "● (M)"
th.git.added_sign = "+ (A)"
th.git.untracked_sign = "○ (U)"
th.git.ignored_sign = "· (I)"
th.git.deleted_sign = "× (D)"
th.git.updated_sign = "↻ (S)"

require("git"):setup()


