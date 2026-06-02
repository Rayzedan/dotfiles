return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  -- you can just use the latest version:
  -- branch = "latest",
  -- or the most up-to-date updates:
  -- branch = "nightly",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
      default_command = {
        cpp = "make -k",
        rust = "cargo run"
      },
    }
    vim.keymap.set('n', '<leader>cc', ":Compile<CR>", { desc = "Run compilation command" })
    vim.keymap.set('n', '<leader>cn', ":NextError<CR>", { desc = "Check next error" })
    vim.keymap.set('n', '<leader>cb', ":PrevError<CR>", { desc = "Check previous error" })
    vim.keymap.set("n", "<leader>cr", ":Recompile<CR>", { desc = "Re-run last compilation" })
  end
}
