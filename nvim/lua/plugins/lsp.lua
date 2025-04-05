return {
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            autoformat = false,
            inlay_hints = { enabled = false },
            lsp = {
                signature = {
                    auto_open = {
                        enabled = false,
                    },
                },
            },
			servers = {
				clangd = {
					cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--header-insertion=never",
					},
				},
			},
        },
    },
}
