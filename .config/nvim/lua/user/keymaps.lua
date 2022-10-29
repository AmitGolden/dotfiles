-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

vim.g.camelcasemotion_key = "-"
vim.cmd([[ let g:sneak#label = 1 ]])

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd> lua require('smart-splits').resize_up(2)<CR>", opts)
keymap("n", "<C-Down>", "<cmd> lua require('smart-splits').resize_down(2)<CR>", opts)
keymap("n", "<C-Left>", "<cmd> lua require('smart-splits').resize_left(2)<CR>", opts)
keymap("n", "<C-Right>", "<cmd> lua require('smart-splits').resize_right(2)<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Stop search highlight on ESC
keymap("n", "<ESC>", ":nohlsearch<CR>", opts)

-- Move text up and down
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert new line without insert mode
keymap("n", "go", "o<ESC>", opts)
keymap("n", "gO", "O<ESC>", opts)

-- Remap marks
keymap("n", "gm", "m", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Paste
keymap("i", "<C-v>", "<ESC>pi", opts)

-- Move in insert mode
keymap("i", "<A-h>", "<Left>", opts)
keymap("i", "<A-j>", "<Down>", opts)
keymap("i", "<A-k>", "<Up>", opts)
keymap("i", "<A-l>", "<Right>", opts)

-- Delete word
keymap("i", "<C-BS>", "<C-w>", opts)

keymap("t", "<C-BS>", "<C-w>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
