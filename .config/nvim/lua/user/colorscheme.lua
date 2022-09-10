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
