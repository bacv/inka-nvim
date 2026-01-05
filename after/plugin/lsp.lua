-- vim.lsp.set_log_level("off")
-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    -- Sets the "workspace" to the directory where any of these files is found.
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        ".git",
    },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
})


vim.lsp.config('rust_analyzer', {
    -- cmd = { 'rust-analyzer' },
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    filetypes = { 'rust' },
    root_markers = {
        ".git",
        "Cargo.lock",
    },
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                targetDir = true,
                allTargets = true,
                allFeatures = true,
            },
            check = { command = 'clippy' },
            checkOnSave = true,
            inlayHints = {
                bindingModeHints = { enabled = true },
                closureCaptureHints = { enabled = true },
                closureReturnTypeHints = { enable = 'always' },
                maxLength = 100,
            },
            completion = {
                postfix = {
                    enable = false,
                },
            },
            rustc = { source = 'discover' },
        }
    }
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')

-- lspconfig.rust_analyzer.setup {
--     on_attach = on_attach,
--     flags = {
--         debounce_text_changes = 150,
--     },
--     settings = {
--         ["rust-analyzer"] = {
--             cargo = {
--                 allFeatures = true,
--             },
--             completion = {
--                 postfix = {
--                     enable = false,
--                 },
--             },
--             checkOnSave = {
--                 command = "clippy"
--             },
--         },
--     },
--     capabilities = capabilities,
--     cmd = { "rustup", "run", "nightly-2025-02-16", "rust-analyzer" },
-- }

-- lspconfig.gopls.setup {
--     on_attach = on_attach,
--     cmd = { "gopls", "serve" },
--     filetypes = { "go", "gomod" },
--     root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--             },
--             staticcheck = true,
--         },
--     },
-- }

-- lspconfig.zls.setup {
--     on_attach = on_attach,
-- }

-- local cmp = require 'cmp'
-- cmp.setup({
--     -- Enable LSP snippets
--     snippet = {
--         expand = function(args)
--             vim.fn["vsnip#anonymous"](args.body)
--         end,
--     },
--     mapping = {
--         ['<M-k>'] = cmp.mapping.select_prev_item(),
--         ['<M-j>'] = cmp.mapping.select_next_item(),
--         -- Add tab support
--         ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--         ['<Tab>'] = cmp.mapping.select_next_item(),
--         ['<M-,>'] = cmp.mapping.scroll_docs(-4),
--         ['<M-m>'] = cmp.mapping.scroll_docs(4),
--         ['<M-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.close(),
--         ['<CR>'] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = true,
--         })
--     },
--     -- Installed sources
--     sources = {
--         { name = 'nvim_lsp' },
--         { name = 'vsnip' },
--         { name = 'path' },
--         { name = 'buffer' },
--     },
--     experimental = {
--         ghost_text = true,
--     },
-- })
--
-- -- Enable completing paths in :
-- cmp.setup.cmdline(':', {
--     sources = cmp.config.sources({
--         { name = 'path' }
--     })
-- })
