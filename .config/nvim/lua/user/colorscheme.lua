local status_ok, theme = pcall(require, "catppuccin")
if not status_ok then
  return
end

vim.g.catppuccin_flavour = "mocha"

theme.setup()

vim.cmd [[colorscheme catppuccin]]
