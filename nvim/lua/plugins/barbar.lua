return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- sidebar_filetypes = {
			-- 	["neo-tree"] = {
			-- 		event = "BufWipeout",
			-- 	},
			-- 	Outline = { event = "BufWipeout", text = "symbols-outline", align = "left" },
			-- },
			tabpages = false,
			icons = {
				buffer_index = false,
				buffer_number = false,
				button = "",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true },
					[vim.diagnostic.severity.WARN] = { enabled = true },
					[vim.diagnostic.severity.INFO] = { enabled = true },
					[vim.diagnostic.severity.HINT] = { enabled = true },
				},
				gitsigns = {
					added = { enabled = true, icon = "+" },
					changed = { enabled = true, icon = "~" },
					deleted = { enabled = true, icon = "-" },
				},
				filetype = {
					custom_colors = false,
					enabled = true,
				},
				separator = { left = "▎", right = "" },

				maximum_padding = 0,
				minimum_padding = 0,

				separator_at_end = false,

				focus_on_close = "left",
				insert_at_end = true,

				modified = { button = "●" },
				pinned = { button = "", filename = true },

				preset = "default",

				alternate = { filetype = { enabled = false } },
				current = { buffer_index = false },
				inactive = { button = "×" },
				visible = { modified = { buffer_number = false } },
			},
		},
	},
}
