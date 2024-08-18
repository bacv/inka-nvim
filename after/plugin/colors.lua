local fileops = require("inka.fileops")

local pine_setup = {
    --- @usage 'auto'|'main'|'moon'|'dawn'
    variant = 'auto',
    --- @usage 'main'|'moon'|'dawn'
    dark_variant = 'main',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,
    --- @usage string hex value or named color from rosepinetheme.com/palette
    groups = {
        background = 'base',
        background_nc = '_experimental_nc',
        panel = 'surface',
        panel_nc = 'base',
        border = 'highlight_med',
        comment = 'muted',
        link = 'iris',
        punctuation = 'subtle',
        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',
        headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
        }
        -- or set all headings at once
        -- headings = 'subtle'
    },
    -- Change specific vim highlight groups
    -- https://github.com/rose-pine/neovim/wiki/Recipes
    highlight_groups = {
        ColorColumn = { bg = 'rose' },
        -- Blend colours against the "base" background
        CursorLine = { bg = 'foam', blend = 10 },
        StatusLine = { fg = 'love', bg = 'love', blend = 10 },
    }
}

local current_theme = "light"

local function set_light()
    vim.opt.background = "light"
    pine_setup.variant = "dawn"

    require('rose-pine').setup(pine_setup)
    vim.cmd.colorscheme("rose-pine")
end

local function set_dark()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("oxocarbon")
end

local function candy_check(conf)
    local theme = fileops.read_file_sync(conf)
    if theme:find(current_theme) == nil then
        CandySet(theme)
    end
end

function CandySet(theme)
    if theme:find('light') then
        set_light()
    else
        set_dark()
    end
    current_theme = theme
end

function CandyInit()
    local conf = vim.fn.stdpath('config') .. "/theme"
    current_theme = fileops.read_file_sync(conf)

    if current_theme:find("dark") == nil then
        set_light()
    else
        set_dark()
    end


    local on_event = function(_, _, _) vim.schedule(function() candy_check(conf) end) end
    local on_error = function(_, _) end

    -- Start watching for changes made to conf by other apps.
    fileops.watch_with_function(conf, on_event, on_error, {})
end

CandyInit()
