return {
  'nvim-lualine/lualine.nvim', -- The path to the lualine.nvim plugin
  event = 'BufReadPre', -- Optionally lazy-load on event
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }, -- Icons support
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'branch' }, -- Show Git branch
        lualine_c = { 'filename' }, -- Show file name
        lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- Encoding/filetype info
        lualine_y = { 'progress' }, -- Progress (e.g., 41%)
        lualine_z = { 'location' }, -- Cursor location (line/column)
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    }
  end,
}
