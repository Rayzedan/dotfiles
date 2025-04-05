-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePre" }, {
  callback = function()
    vim.cmd("silent %s/\\s\\+$//ge")
    vim.cmd("silent %s/\\t/    /ge")
  end,
})
