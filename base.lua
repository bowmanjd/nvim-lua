home = os.getenv("HOME") or os.getenv("USERPROFILE")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.hidden = true
vim.opt.mouse = "a"

vim.opt.fileformat = "unix"
vim.opt.fileformats = { "unix", "dos" }
vim.opt.fixeol = false

vim.opt.backup = false
vim.opt.writebackup = true

vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"

vim.opt.background = "dark"
vim.opt.termguicolors = true

if vim.fn.executable("win32yank") == 1 and os.getenv("SSH_CONNECTION") == nil then
	vim.g.clipboard = {
		name = "win32yank",
		copy = {
			["+"] = "win32yank -i",
			["*"] = "win32yank -i",
		},
		paste = {
			["+"] = "win32yank -o --lf",
			["*"] = "win32yank -o --lf",
		},
		cache_enabled = 0,
	}
else
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
		},
	}
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.md" },
	callback = function()
		vim.bo.filetype = "markdown"
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
		vim.opt_local.formatoptions = "l"
		vim.opt_local.linebreak = true
		vim.opt_local.wrap = true
		vim.opt_local.textwidth = 0
		vim.opt_local.wrapmargin = 0
		vim.opt_local.list = false
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "ssh_config", "*/.ssh/config.d/*" },
	callback = function()
		vim.bo.filetype = "sshconfig"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.sql" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
		vim.opt_local.fileformat = "unix"
	end,
})

vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float()
end, { desc = "[e] show line diagnostics" })

require("age")
