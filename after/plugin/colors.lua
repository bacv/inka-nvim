local fileops = require("inka.fileops")

local pine_setup = {
    variant = "auto",      -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = false,

    enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    palette = {
        -- Override the builtin palette per variant
        main = {
            base = '#0d0a0a',
        },
    },
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
    pine_setup.variant = "main"

    require('rose-pine').setup(pine_setup)
    vim.cmd.colorscheme("rose-pine")
end

local function candy_check(conf)
    local theme, err = fileops.read_file_sync(conf)
    if not theme then
        vim.notify("Error loading theme configuration: " .. err, vim.log.levels.ERROR)
        return
    end

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

function CandyToggle()
    if current_theme:find('light') then
        set_dark()
        current_theme = "dark"
    else
        set_light()
        current_theme = "light"
    end
end

function CandyInit()
    local conf = vim.fn.stdpath('config') .. "/theme"
    current_theme, err = fileops.read_file_sync(conf)
    if not current_theme then
        vim.notify("Error loading theme configuration: " .. err, vim.log.levels.ERROR)
        current_theme = "dark"
    end

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
