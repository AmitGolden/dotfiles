local status_ok, substitute = pcall(require, "substitute")
if not status_ok then
	return
end

substitute.setup()

vim.keymap.set("n", "<leader>p", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>pp", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>P", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
