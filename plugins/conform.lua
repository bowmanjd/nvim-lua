require("conform").setup({
	formatters_by_ft = {
		cs = { "csharpier" },
		css = { "stylelint" },
		html = { "prettierd", "prettier", "djlint", stop_after_first = true },
		lua = { "stylua" },
		nix = { "alejandra" },
		python = { "ruff_organize_imports", "ruff_format" },
		rust = { "rustfmt" },
		javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
		typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "biome", "prettierd", "prettier", stop_after_first = true },
		jsonc = { "biome", "prettierd", "prettier", stop_after_first = true },
		sql = { "sqruff" },
		xml = { "xmllint" },
	},
	default_format_opts = {
		async = true,
		lsp_format = "fallback",
		timeout_ms = 60000,
	},
	formatters = {
		sqruff = {
			stdin = true,
			-- sqruff exits 1 when unfixable issues remain, but still prints the fixed SQL
			exit_codes = { 0, 1 },
			args = function()
				local sql = require("sql")
				return { "fix", "--dialect", sql.dialect(), "--config", sql.config, "-" }
			end,
		},
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format()
end, { desc = "Format buffer" })
