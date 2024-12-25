return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config

	opts = {
		keymap = { preset = "enter" },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},
		completion = {
			menu = {
				border = "single",
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline"
				end,
			},
			ghost_text = {
				enabled = false,
			},
			documentation = {
				window = {
					border = "single",
				},
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
		signature = {
			window = {
				border = "single",
			},
		},
	},
	opts_extend = {
		"sources.default",
	},
}
