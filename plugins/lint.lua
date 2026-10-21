return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>l",
				function()
					require("lint").try_lint()
				end,
				desc = "Lint buffer",
			},
			{
				"<leader>L",
				function()
					vim.diagnostic.enable(not vim.diagnostic.is_enabled())
				end,
				desc = "Toggle diagnostics",
			},
		},
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = lint.linters_by_ft or {}
			lint.linters_by_ft["markdown"] = { "markdownlint" }
			lint.linters_by_ft["sql"] = { "sqruff" }
			-- js/ts/json diagnostics come from the biome LSP
			lint.linters_by_ft["javascriptreact"] = { "eslint" }

			local sql = require("sql")
			lint.linters.sqruff.args = {
				"lint",
				"--format=json",
				"--dialect",
				sql.dialect,
				"--config",
				sql.config,
				"-",
			}

			-- Run linter on file open and after save to prevent typing lag
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				group = lint_augroup,
				callback = function()
					-- Only run the linter in modifiable buffers
					if vim.opt_local.modifiable:get() then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
