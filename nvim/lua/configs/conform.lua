local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    rs = { "rust_analyzer" },
    ts = { "ts_ls" },
    js = { "ts_ls" },
    sh = { "shfmt" },
    go = { "golangci_lint_ls" },
    c = { "clang-format" },
    o = { "clang-format" },
    h = { "clang-format" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
