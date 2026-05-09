local fileops = require("files")

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


local function set(colors)
    local default_fg = { fg = colors.foreground }
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

        Identifier   = default_fg,
        Type         = default_fg,
        Constant     = default_fg,
        Statement    = default_fg,
        PreProc      = default_fg,
        Special      = default_fg,
        Delimiter    = default_fg,
        Operator     = default_fg,

        LineNr       = default_fg,
    }

    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

local current_theme = "light"

local function set_light()
    vim.opt.background = "light"
    set(light)
end

local function set_dark()
    vim.opt.background = "dark"
    set(dark)
end


local M = {}

function M:check(conf)
    local theme, err = fileops.read_file_sync(conf)
    if not theme then
        vim.notify("Error loading theme configuration: " .. err, vim.log.levels.ERROR)
        return
    end

    if theme:find(current_theme) == nil then
        self:set(theme)
    end
end

function M:set(theme)
    if theme:find('light') then
        set_light()
    else
        set_dark()
    end
    current_theme = theme
end

function M:toggle()
    if current_theme:find('light') then
        set_dark()
        current_theme = "dark"
    else
        set_light()
        current_theme = "light"
    end
end

function M:init()
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


    local on_event = function(_, _, _) vim.schedule(function() self:check(conf) end) end
    local on_error = function(_, _) end

    -- Start watching for changes made to conf by other apps.
    fileops.watch_with_function(conf, on_event, on_error, {})
end

return M
