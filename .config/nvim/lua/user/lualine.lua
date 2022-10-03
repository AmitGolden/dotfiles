local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = "樂", modified = " ", removed = " " },
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

local location = {
	"location",
	padding = { right = 1, left = 0 },
}

local branch = { "branch", icon = "" }

local lsp = {
	function()
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			return "no lsp"
		end
		local buf_ft = vim.bo.filetype
		local buf_client_names = {}

		-- add client
		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" then
				table.insert(buf_client_names, client.name)
			end
		end

		local s = require("null-ls.sources")
		local available_sources = s.get_available(buf_ft)
		local providers = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				providers[method] = providers[method] or {}
				table.insert(providers[method], source.name)
			end
		end

		-- add formatter
		local supported_formatters = providers[null_ls.methods.FORMATTING] or {}
		vim.list_extend(buf_client_names, supported_formatters)

		-- add linter
		local supported_linters = providers[null_ls.methods.DIAGNOSTICS] or {}
		vim.list_extend(buf_client_names, supported_linters)

		local unique_client_names = vim.fn.uniq(buf_client_names)
		return table.concat(unique_client_names, ", ")
	end,
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = "|",
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch },
		lualine_c = { diagnostics },
		lualine_x = { lsp, diff, "encoding", spaces, filetype },
		lualine_y = { "progress" },
		lualine_z = { location },
	},
})
