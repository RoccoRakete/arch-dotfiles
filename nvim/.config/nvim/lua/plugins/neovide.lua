if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        -- line spacing
        linespace = 0,
      },
      g = { -- configure vim.g variables
        -- configure scaling
        neovide_scale_factor = 1,
        -- configure padding
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
        vim.api.nvim_set_keymap("n", "<C-S-v>", '"+p', { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("i", "<C-S-v>", "<C-r>+", { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("v", "<C-S-v>", '"+p', { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("n", "<C-S-c>", '"+yy', { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("v", "<C-S-c>", '"+y', { noremap = true, silent = true }),
      },
    },
  },
}
