return {
  { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  { 'neanias/everforest-nvim' },
  { 'rmehri01/onenord.nvim' },
  { 'projekt0n/github-nvim-theme' },
  { 'sainnhe/edge' },
  { 'tiagovla/tokyodark.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'olimorris/onedarkpro.nvim' },
  { 'NTBBloodbath/doom-one.nvim' },
  { 'miikanissi/modus-themes.nvim' },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
  {
    'dgox16/oldworld.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'thesimonho/kanagawa-paper.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
      vim.cmd.colorscheme("kanagawa-paper")
    end
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'kanagawa-paper-link',
    },
  },
}
