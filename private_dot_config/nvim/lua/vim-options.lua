vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader= " "

-- Add line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- removes highlighting from search results
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Navigate between tabs with H and L
vim.keymap.set('n', 'H', '<cmd>tabprevious<cr>', { desc = 'Go to previous tab' })
vim.keymap.set('n', 'L', '<cmd>tabnext<cr>', { desc = 'Go to next tab' })

-- Custom function to show only filename in tabs
function MyTabLabel(tabnr)
    local bufnr = vim.fn.tabpagebuflist(tabnr)[vim.fn.tabpagewinnr(tabnr)]
    local bufname = vim.fn.bufname(bufnr)
    local modified = vim.fn.getbufvar(bufnr, '&modified') == 1
    
    local tablabel = ''
    if bufname == '' then
        tablabel = '[No Name]'
    else
        -- Use :t modifier to get only the filename
        tablabel = vim.fn.fnamemodify(bufname, ':t')
    end
    
    -- Add * for modified files
    if modified then
        tablabel = tablabel .. '*'
    end
    
    return tablabel
end

function MyTabLine()
    local tabline = ''
    for i = 1, vim.fn.tabpagenr('$') do
        local is_current = i == vim.fn.tabpagenr()
        tabline = tabline .. (is_current and '%#TabLineSel#' or '%#TabLine#')
        tabline = tabline .. '%' .. i .. 'T ' .. MyTabLabel(i) .. ' '
    end
    tabline = tabline .. '%#TabLineFill#%T'
    return tabline
end

-- Set the custom tabline
vim.o.tabline = '%!v:lua.MyTabLine()'
vim.o.showtabline = 2
vim.keymap.set('n', '<leader>nr', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })
