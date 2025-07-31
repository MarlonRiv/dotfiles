return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Enhanced fold text with line count
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰁂 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end

    -- Enhanced navigation functions
    local function goNextClosedAndPeek()
      require('ufo').goNextClosedFold()
      require('ufo').peekFoldedLinesUnderCursor()
    end
    local function goPreviousClosedAndPeek()
      require('ufo').goPreviousClosedFold()
      require('ufo').peekFoldedLinesUnderCursor()
    end

    -- Key mappings
    vim.keymap.set('n', 'zr', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zm', require('ufo').closeAllFolds)
    vim.keymap.set('n', ']z', goNextClosedAndPeek, { desc = 'Next fold and peek' })
    vim.keymap.set('n', '[z', goPreviousClosedAndPeek, { desc = 'Previous fold and peek' })

    -- Setup with custom fold text
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
      fold_virt_text_handler = handler
    })
  end
}
