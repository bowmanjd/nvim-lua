-- Only installed by Nix, so skip it where the plugin is missing (Windows)
local ok, direnv = pcall(require, "direnv")
if ok and vim.fn.executable("direnv") == 1 then
	direnv.setup({ autoload_direnv = true })
end
