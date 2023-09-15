vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
	},
	renderer = {
		group_empty = true,
		indent_markers = {
			enable = false,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = "➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "⬡",
				symlink = "よ",
				bookmark = "ん",
				folder = {
					arrow_closed = "-",
					arrow_open = ">",
					default = "⬡",
					open = ">",
					empty = "o",
					empty_open = "O",
					symlink = "^",
					symlink_open = "|",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "⁕",
					renamed = "r!",
					untracked = "**",
					deleted = "†",
					ignored = "i'",
				},
			},
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		symlink_destination = true,
	},
})
