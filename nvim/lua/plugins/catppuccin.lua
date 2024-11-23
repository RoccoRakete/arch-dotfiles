return {
  "catppuccin/nvim",
  name = "catppuccin-moca",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
