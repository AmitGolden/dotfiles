local status_ok, substitute = pcall(require, "substitute")
if not status_ok then
	return
end

substitute.setup()

vim.keymap.set("n", "<leader>s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
