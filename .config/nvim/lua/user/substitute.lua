local status_ok, substitute = pcall(require, "substitute")
if not status_ok then
	return
end

substitute.setup()

vim.keymap.set("n", "<leader>y", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>yy", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>Y", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
