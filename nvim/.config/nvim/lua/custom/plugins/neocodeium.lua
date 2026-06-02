return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  enabled = false,
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    vim.keymap.set("i", "<C-e>", neocodeium.accept)
  end,
}
