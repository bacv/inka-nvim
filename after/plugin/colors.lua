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

local function pineCheck(pineconf)
	local theme = fileops.read_file_sync(pineconf)
	if theme:find(pine_setup.variant) == nil then
		PineToggle()
	end
end

function PineToggle()
	local variant = pine_setup.variant
	if variant == 'main' then
		pine_setup.variant = 'dawn'
	else
		pine_setup.variant = 'main'
	end
	require('rose-pine').setup(pine_setup)
	vim.cmd.colorscheme("rose-pine")
end

function PineInit()
	local pineconf = vim.fn.stdpath('config') .. "/pineconf"
	local theme = fileops.read_file_sync(pineconf)

	if theme:find("main") == nil then
		pine_setup.variant = "dawn"
	else
		pine_setup.variant = "main"
	end

	require('rose-pine').setup(pine_setup)
	vim.cmd.colorscheme("rose-pine")

	local on_event = function(_, _, _) vim.schedule(function() pineCheck(pineconf) end) end
	local on_error = function(_, _) end

	-- Start watching for changes made to pineconf by other apps.
	fileops.watch_with_function(pineconf, on_event, on_error, {})
end

PineInit()
