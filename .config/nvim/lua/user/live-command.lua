local status_ok, live = pcall(require, "live-command")
if not status_ok then
	return
end

live.setup({
	commands = {
		Norm = { cmd = "norm" },
		G = { cmd = "g" },
		S = { cmd = "s" },
		Mac = {
			cmd = "norm",
			-- This will transform ":5Mac a" into ":norm 5@a"
			args = function(opts)
				return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
			end,
			range = "",
		},
	},
})
