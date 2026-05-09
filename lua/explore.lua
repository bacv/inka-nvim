local function create_float()
    local buf = vim.api.nvim_create_buf(false, true)
    local win_opts = {
        relative = 'editor',
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        row = math.floor(vim.o.lines * 0.1),
        col = math.floor(vim.o.columns * 0.1),
        style = 'minimal',
        border = 'rounded'
    }
    local win = vim.api.nvim_open_win(buf, true, win_opts)
    return buf, win
end

local fzf = function(cwd)
    local _, win = create_float()
    local temp_file = os.tmpname()

    -- We use printf to inject ANSI codes:
    -- %s (Gray path) / %s (Default filename)
    local list_cmd = [[fd --type f | while read l; do printf "\x1b[38;5;242m%s/\x1b[0m%s\n" "$(pwd)" "$l"; done]]

    local fzf_cmd = "fzf --ansi " ..
        "--header 'C-u: Parent Dir' " ..
        "--bind 'ctrl-u:reload(cd .. && " .. list_cmd .. ")' " ..
        "--nth -1 " .. -- Only search the filename (the part after the last /)
        "> " .. temp_file

    local full_cmd = string.format("cd %s && %s | %s", vim.fn.shellescape(cwd), list_cmd, fzf_cmd)

    vim.fn.termopen(full_cmd, {
        on_exit = function()
            if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end

            local f = io.open(temp_file, "r")
            if f then
                local selected = f:read("*l")
                f:close()
                os.remove(temp_file)

                if selected and selected ~= "" then
                    -- CRITICAL: Strip the ANSI codes before Neovim tries to open the path
                    local clean_path = selected:gsub("\27%[[%d;]*m", "")
                    vim.cmd("edit " .. vim.fn.fnameescape(clean_path))
                end
            end
        end
    })
    vim.cmd("startinsert")
end

local grep = function(cwd)
    local _, win = create_float()
    local temp_file = os.tmpname()

    local rg_cmd = "rg --column --line-number --no-heading --color=always --smart-case \"\""
    local fzf_cmd = "fzf --ansi > " .. temp_file
    local full_cmd = "cd " .. cwd .. ";" .. rg_cmd .. " | " .. fzf_cmd

    vim.fn.termopen(full_cmd, {
        on_exit = function()
            if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
            local f = io.open(temp_file, "r")
            if f then
                local line = f:read("*l")
                f:close()
                os.remove(temp_file)

                if line then
                    local parts = vim.split(line, ":")
                    local filename = parts[1]
                    local full_path = cwd .. "/" .. filename
                    local row = parts[2]
                    local col = parts[3]

                    vim.cmd("edit " .. vim.fn.fnameescape(full_path))
                    vim.api.nvim_win_set_cursor(0, { tonumber(row), tonumber(col) - 1 })
                end
            end
        end
    })
    vim.cmd("startinsert")
end

local M = {}

function M:fzf_root()
    local cwd = vim.fn.getcwd()
    fzf(cwd)
end

function M:fzf_relative()
    local cwd = vim.fn.expand('%:p:h')
    fzf(cwd)
end

function M:grep_root()
    local cwd = vim.fn.getcwd()
    grep(cwd)
end

function M:grep_relative()
    local cwd = vim.fn.expand('%:p:h')
    grep(cwd)
end

return M
