vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

if vim.g.neovide then
  vim.o.guifont = "Hurmit Nerd Font:h12"
  vim.g.neovide_padding_top = 20
  vim.api.nvim_set_keymap("n", "<C-S-v>", '"+p', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("i", "<C-S-v>", "<C-r>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<C-S-v>", '"+p', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<C-S-c>", '"+yy', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<C-S-c>", '"+y', { noremap = true, silent = true })
end

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start {
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    }
  end,
})
