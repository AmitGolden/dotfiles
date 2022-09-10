local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
	return
end

signature.setup({})
