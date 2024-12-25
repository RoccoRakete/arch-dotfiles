return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"prettier",
					"tflint",
				},
			})
		end,
	},
	-- Mason-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"bashls",
					"cssls",
					"gopls",
					"ts_ls",
					"jsonls",
					"markdown_oxide",
					"pylyzer",
					"rust_analyzer",
					"yamlls",
					"terraformls",
				},
			})
		end,
	},
	-- nvim-lspconfig

	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },

		-- example using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {},
				clangd = {},
				terraformls = {},
				gopls = {},
				bashls = {},
				cssls = {},
				jsonls = {},
				pylyzer = {},
				rust_analyzer = {},
				ts_ls = {},
				yamlls = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
	},

	-- {
	-- 	"neovim/nvim-lspconfig",
	--
	-- 	config = function()
	-- 		local lspconfig = require("lspconfig")
	-- 		local capabilities = require("cmp_nvim_lsp").default_capabilities()
	-- 		local tf_capb = vim.lsp.protocol.make_client_capabilities()
	-- 		tf_capb.textDocument.completion.completionItem.snippetSupport = true
	--
	-- 		lspconfig.terraformls.setup({
	-- 			filetypes = { "terraform", "terraform-vars", "tf" },
	-- 			root_dir = function(dirpath) end,
	-- 		})
	--
	-- 		lspconfig.terraformls.setup({
	-- 			flags = { debounce_text_changes = 150 },
	-- 			capabilities = tf_capb,
	-- 		})
	--
	-- 		lspconfig.lua_ls.setup({
	-- 			capabilities = capabilities,
	-- 		})
	--
	-- 		lspconfig.cssls.setup({
	-- 			capabilities = capabilities,
	-- 		})
	--
	-- 		lspconfig.rust_analyzer.setup({
	-- 			capabilities = capabilities,
	-- 		})
	--
	-- 		lspconfig.gopls.setup({
	-- 			cmd = { "gopls" },
	-- 			on_attach = on_attach,
	-- 			capabilities = capabilities,
	-- 			settings = {
	-- 				gopls = {
	-- 					experimentalPostfixCompletions = true,
	-- 					analyses = {
	-- 						unusedparams = true,
	-- 						shadow = true,
	-- 					},
	-- 					staticcheck = true,
	-- 				},
	-- 			},
	-- 			init_options = {
	-- 				usePlaceholders = true,
	-- 			},
	-- 		})
	--
	-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	-- 		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
	-- 		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	-- 	end,
	-- },
	-- Conform
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					scss = { "prettierd" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
					sh = { "shfmt" },
					rust = { "rustfmt" },
					hcl = { "packer_fmt" },
					terraform = { "terraform_fmt" },
					tf = { "terraform_fmt" },
					["terraform-vars"] = { "terraform_fmt" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>bf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
	-- none-ls
	{
		"nvimtools/none-ls.nvim",

		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.packer,
					null_ls.builtins.formatting.terraform_fmt,
					-- null_ls.builtins.diagnostics.terraform_validate,
				},
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
	{
		-- 	"hrsh7th/cmp-path",
		-- 	config = function()
		-- 		local cmp = require("cmp-path")
		-- 		require("cmp").setup({
		-- 			sources = {
		-- 				{ name = "path" },
		-- 			},
		-- 		})
		-- 		cmp.setup({
		-- 			sources = {
		-- 				{
		-- 					name = "path",
		-- 					option = {
		-- 						-- Options go into this table
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		-- 	end,
	},
}
