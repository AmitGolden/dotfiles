local status_ok, theme = pcall(require, "catppuccin")
if not status_ok then
	return
end

vim.g.catppuccin_flavour = "mocha"

theme.setup({
	transparent_background = false,
	integrations = {
		dap = {
			enabled = true,
			enable_ui = true,
		},
		vim_sneak = true,
		ts_rainbow = true,
		which_key = true,
	},
})

vim.cmd([[colorscheme catppuccin]])

local colors = require("catppuccin.palettes").get_palette()

vim.cmd([[
hi def IlluminatedWordText guibg=#45475A
hi def IlluminatedWordWrite guibg=#45475A
hi def IlluminatedWordRead guibg=#45475A
]])

vim.g.terminal_color_0 = colors.surface1
vim.g.terminal_color_8 = colors.surface2

vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_9 = colors.red

vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_10 = colors.green

vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_11 = colors.yellow

vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_12 = colors.blue

vim.g.terminal_color_5 = colors.magenta
vim.g.terminal_color_13 = colors.magenta

vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_14 = colors.cyan

vim.g.terminal_color_7 = colors.subtext1
vim.g.terminal_color_15 = colors.subtext0
