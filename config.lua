-- Entry point shared by NixOS and Windows: init.lua only needs require("config").
-- On NixOS, Nix installs the plugins and sets vim.g.nix before this runs.
require("base")

if not vim.g.nix then
	require("pack")
end

require("plugins.colors")
require("plugins.editing")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.completion")
require("plugins.lsp")
require("plugins.conform")
require("plugins.lint")
require("plugins.git")
require("plugins.lualine")
require("plugins.oil")
require("plugins.which-key")
require("plugins.direnv")
