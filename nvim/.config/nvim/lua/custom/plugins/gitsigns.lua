return {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- Actions
        -- normal mode
        vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        vim.keymap.set('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        vim.keymap.set('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
}
