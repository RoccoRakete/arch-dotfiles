return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"lua",
				"c",
				"rust",
				"typescript",
				"javascript",
				"python",
				"terraform",
				"hcl",
				"go",
				"gowork",
				"gomod",
				"gosum",
				"sql",
				"gotmpl",
				"json",
				"jsonc",
				"comment",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
