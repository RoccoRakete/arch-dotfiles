-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "arduino_language_server",
        "astro",
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "css_variables",
        "cssmodules_ls",
        "jsonls",
        "markdown_oxide",
        "pylsp",
        "rust_analyzer",
        "somesass_ls",
        "pylyzer",
        "tsserver",
        --"hyprls",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        "selene",
        "clang-format",
        "cmakelang",
        "jq",
        "jsonnetfmt",
        "luaformatter",
        "prettierer",
        "prettiererd",
        "rustup",
        "shfmt",
        "black",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        -- add more arguments for adding more debuggers
      },
    },
  },
}
