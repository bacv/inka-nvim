local files = require("files")

vim.lsp.config['lua_ls'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2"
                }
            }
        }
    }
}

vim.lsp.config("rust_analyzer", {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    filetypes = { 'rust' },
    capabilities = {
        experimental = {
            serverStatusNotification = true,
            commands = {
                commands = {
                    'rust-analyzer.showReferences',
                    'rust-analyzer.runSingle',
                    'rust-analyzer.debugSingle',
                },
            },
        },
    },
    settings = {
        ["rust-analyzer"] = {
            files = { watcher = "server" },
            cargo = {
                targetDir = true,
                allTargets = true,
                allFeatures = true,
            },
            check = { command = "clippy" },
            checkOnSave = true,
            inlayHints = {
                bindingModeHints = { enabled = true },
                closureCaptureHints = { enabled = true },
                closureReturnTypeHints = { enable = "always" },
                maxLength = 100,
            },
            rustc = { source = "discover" },
        },
    },
    root_markers = { { "Config.toml" }, ".git" },
})


vim.lsp.enable('lua_ls')
vim.lsp.enable("rust_analyzer")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.updatetime = 50
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 50

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Paste over selected text, but keep the paste in the clipboard.
vim.keymap.set("x", "<leader>p", [["_dP]])
-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set('i', '<c-p>', function()
    vim.lsp.completion.get()
end)

-- lsp
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end)
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end)
vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', '<leader>D', function() vim.lsp.buf.type_definition() end)
vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', '<leader>a', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end)
vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end)
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end)
vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end)
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, {})
        end
    end,
})

vim.keymap.set('i', '<A-j>', function()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<A-j>'
end, { expr = true })

vim.keymap.set('i', '<A-k>', function()
    return vim.fn.pumvisible() == 1 and '<C-p>' or '<A-k>'
end, { expr = true })

vim.opt.completeopt = { "menuone", "noselect", "noinsert", "popup", "preview" }
vim.keymap.set('i', '<C-c>', '<C-x><C-o>', { noremap = true })

vim.keymap.set('n', '<leader>jj', files.explore_root)
vim.keymap.set('n', '<leader>ji', files.explore_relative)
vim.keymap.set('n', '<leader>jk', files.grep_root)
vim.keymap.set('n', '<leader>kk', files.grep_relative)

local dark = {
    functions        = "#ea9a97",
    strings          = "#f6c177",
    keywords         = "#eb6f92",
    background       = "#0d0a0a",
    foreground       = "#faf4ed",
    selection        = "#275F69",
    status           = "#56949f",
    status_inactive  = "#cecacd",
    search           = "#FF4949",
    search_current   = "#FFC300",
    float_background = "#26233a",
    comments         = "#6e6a86"
}

local light = {
    functions        = "#d7827e",
    strings          = "#ea9d34",
    keywords         = "#b4637a",
    background       = "#faf4ed",
    foreground       = "#575279",
    selection        = "#9ccfd8",
    status           = "#ea9a97",
    status_inactive  = "#9893a5",
    search           = "#FFF172",
    search_current   = "#FF4949",
    float_background = "#f2e9e1",
    comments         = "#9893a5"
}

local colors = light
vim.o.background = "light"

local highlights = {
    Function     = { fg = colors.functions, bold = true },
    String       = { fg = colors.strings },
    Keyword      = { fg = colors.keywords, italic = true },
    Normal       = { fg = colors.foreground, bg = colors.background },
    NormalFloat  = { fg = colors.foreground, bg = colors.float_background },
    FloatBorder  = { fg = colors.foreground, bg = colors.background },
    Visual       = { fg = "NONE", bg = colors.selection },
    StatusLine   = { fg = colors.background, bg = colors.status },
    StatusLineNC = { fg = colors.background, bg = colors.status_inactive },
    Search       = { fg = colors.foreground, bg = colors.search },
    CurSearch    = { fg = colors.background, bg = colors.search_current },
    MatchParen   = { fg = "NONE", bg = colors.selection },
    Comment      = { fg = colors.comments },
}

for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
end

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
