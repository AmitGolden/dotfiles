local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	indent = { enable = true, disable = { "python", "css" } },
	matchup = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			-- automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- you can use the capture groups defined in textobjects.scm
				["af"] = "@call.outer",
				["if"] = "@call.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			},
		},
	},
	textsubjects = {
		enable = true,
		prev_selection = ",", -- (Optional) keymap to select the previous selection
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
			["i;"] = "textsubjects-container-inner",
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	}
})

vim.g.matchup_matchparen_offscreen = { method = "popup" }
