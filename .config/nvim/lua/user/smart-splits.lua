local status_ok, splits = pcall(require, "smart-splits")
if not status_ok then
	return
end

splits.setup({})
