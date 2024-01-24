local uv = vim.loop

-- @doc """
-- Watch path and calls on_event(filename, events) or on_error(error)
--
-- opts:
--  is_oneshot -> don't reattach after running, no matter the return value
-- """
local function watch_with_function(path, on_event, on_error, opts)
    -- TODO: Check for 'fail'? What is 'fail' in the context of handle creation?
    --       Probably everything else is on fire anyway (or no inotify/etc?).
    local handle = uv.new_fs_event()

    -- these are just the default values
    local flags = {
        watch_entry = false, -- true = when dir, watch dir inode, not dir content
        stat = false,        -- true = don't use inotify/kqueue but periodic check, not implemented
        recursive = false    -- true = watch dirs inside dirs
    }

    local unwatch_cb = function()
        uv.fs_event_stop(handle)
    end

    local event_cb = function(err, filename, events)
        if err then
            on_error(error, unwatch_cb)
        else
            on_event(filename, events, unwatch_cb)
        end
        if opts.is_oneshot then
            unwatch_cb()
        end
    end

    -- attach handler
    uv.fs_event_start(handle, path, flags, event_cb)

    return handle
end

local function read_file_sync(path)
    local fd = assert(uv.fs_open(path, "r", 438))
    local stat = assert(uv.fs_fstat(fd))
    local data = assert(uv.fs_read(fd, stat.size, 0))
    assert(uv.fs_close(fd))
    return data
end

local M = {
    read_file_sync = read_file_sync,
    watch_with_function = watch_with_function,
}

return M
