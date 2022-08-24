local status_ok, diff = pcall(require, "diffview")
if not status_ok then
  return
end

diff.setup()
