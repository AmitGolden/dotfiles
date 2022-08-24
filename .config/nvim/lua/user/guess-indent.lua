local status_ok, guess = pcall(require, "guess-indent")
if not status_ok then
	return
end

guess.setup()
