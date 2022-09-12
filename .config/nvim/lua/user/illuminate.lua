local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
	return
end

illuminate.configure({
	filetypes_denylist = {
		"alpha",
		"NvimTree",
		"qf"
	},
})

vim.api.nvim_set_keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<a-p>",
	'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
	{ noremap = true }
)
