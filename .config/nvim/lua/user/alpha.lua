local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

-- Inspired by https://github.com/glepnir/dashboard-nvim with my own flair
local header = {
	[[                                                                   ]],
	[[      ████ ██████           █████      ██                    ]],
	[[     ███████████             █████                            ]],
	[[     █████████ ███████████████████ ███   ███████████  ]],
	[[    █████████  ███    █████████████ █████ ██████████████  ]],
	[[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
	[[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
	[[██████  █████████████████████ ████ █████ █████ ████ ██████]],
}

-- Make the header a bit more fun with some color!
local function colorize_header()
	local catppuccin = require("catppuccin.palettes").get_palette()
	local colors = {
		catppuccin.red,
		catppuccin.red,
		catppuccin.peach,
		catppuccin.yellow,
		catppuccin.green,
		catppuccin.sky,
		catppuccin.blue,
		catppuccin.mauve,
		catppuccin.overlay0,
	}
	for i, color in pairs(colors) do
		local cmd = "hi StartLogo" .. i .. " guifg=" .. color
		vim.cmd(cmd)
	end

	local lines = {}

	for i, chars in pairs(header) do
		local line = {
			type = "text",
			val = chars,
			opts = {
				hl = "StartLogo" .. i,
				shrink_margin = false,
				position = "center",
			},
		}

		table.insert(lines, line)
	end

	return lines
end

dashboard.section.buttons.val = {
	dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
	dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

-- Everyone could use a good fortune cookie from time to time, right?
dashboard.section.footer.val = fortune()
dashboard.section.footer.opts.hl = "StartLogo9"

-- Hide all the unnecessary visual elements while on the dashboard, and add
-- them back when leaving the dashboard.
local group = vim.api.nvim_create_augroup("CleanDashboard", {})

vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "AlphaReady",
	callback = function()
		vim.opt.showtabline = 0
		vim.opt.showmode = false
		vim.opt.laststatus = 0
		vim.opt.showcmd = false
		vim.opt.ruler = false
	end,
})

vim.api.nvim_create_autocmd("BufUnload", {
	group = group,
	pattern = "<buffer>",
	callback = function()
		vim.opt.showtabline = 2
		vim.opt.showmode = true
		vim.opt.laststatus = 3
		vim.opt.showcmd = true
		vim.opt.ruler = true
	end,
})

alpha.setup({
	layout = {
		{ type = "padding", val = 8 },
		{ type = "group", val = colorize_header() },
		{ type = "padding", val = 3 },
		dashboard.section.buttons,
		{ type = "padding", val = 1 },
		dashboard.section.footer,
	},
	opts = { margin = 5 },
})
