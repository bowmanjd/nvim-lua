-- Non-Nix machines (Windows): install plugins with Neovim's built-in vim.pack.
-- Keep in sync with programs.neovim.plugins in home-manager/nvim/default.nix.
local function gh(repo)
	return "https://github.com/" .. repo
end

-- tree-sitter defaults to MSVC (cl.exe) on Windows; use gcc (scoop) for :TSInstall instead
if not vim.env.CC and vim.fn.executable("gcc") == 1 then
	vim.env.CC = "gcc"
end

vim.pack.add({
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	gh("hrsh7th/cmp-buffer"),
	gh("hrsh7th/cmp-nvim-lsp"),
	gh("hrsh7th/cmp-path"),
	gh("stevearc/conform.nvim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("nmac427/guess-indent.nvim"),
	gh("lukas-reineke/indent-blankline.nvim"),
	gh("onsails/lspkind.nvim"),
	gh("nvim-lualine/lualine.nvim"),
	gh("nvim-mini/mini.surround"),
	gh("Hoffs/omnisharp-extended-lsp.nvim"),
	gh("hrsh7th/nvim-cmp"),
	gh("mfussenegger/nvim-lint"),
	gh("neovim/nvim-lspconfig"),
	-- Parsers are not bundled here; install with :TSInstall (needs tree-sitter CLI and a C compiler)
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
	gh("nvim-tree/nvim-web-devicons"),
	gh("stevearc/oil.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
	gh("akinsho/toggleterm.nvim"),
	gh("folke/which-key.nvim"),
})
