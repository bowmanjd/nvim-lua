-- age.lua: transparent editing of age-encrypted (*.age) files
-- Decrypts on read via agegent, re-encrypts on write via rage.

local age_group = vim.api.nvim_create_augroup("AgeEncryption", { clear = true })

local age_pub = (home or os.getenv("HOME")) .. "/.ssh/secrets/age.key.pub"
local rage_encrypt_cmd = "rage -a -R " .. age_pub

-- Before reading: decrypt the file contents into the buffer
vim.api.nvim_create_autocmd("BufReadPre", {
	group = age_group,
	pattern = "*.age",
	callback = function()
		vim.opt_local.bin = true
		vim.opt_local.swapfile = false
		vim.opt_local.backup = false
		vim.opt_local.writebackup = false
		vim.opt_local.undofile = false
		vim.opt_local.viminfo = ""
	end,
})

-- After reading: replace buffer contents with decrypted plaintext
vim.api.nvim_create_autocmd("BufReadPost", {
	group = age_group,
	pattern = "*.age",
	callback = function()
		local file = vim.fn.expand("%:p")
		-- Decrypt file contents via agegent and replace buffer
		vim.cmd("silent %!agegent " .. vim.fn.shellescape(file))
		vim.opt_local.bin = false
		vim.bo.modified = false
		vim.bo.filetype = ""
		-- Re-detect filetype from the underlying name minus .age
		local inner = vim.fn.expand("%:r")
		local ext = vim.fn.fnamemodify(inner, ":e")
		if ext ~= "" then
			local ft = vim.filetype.match({ filename = inner })
			if ft then
				vim.bo.filetype = ft
			end
		end
	end,
})

-- Before writing: encrypt the buffer contents back to the file
vim.api.nvim_create_autocmd("BufWritePre", {
	group = age_group,
	pattern = "*.age",
	callback = function()
		vim.opt_local.bin = true
		-- Encrypt the entire buffer in-place
		vim.cmd("silent %!" .. rage_encrypt_cmd)
	end,
})

-- After writing: decrypt the buffer again so editing can continue
vim.api.nvim_create_autocmd("BufWritePost", {
	group = age_group,
	pattern = "*.age",
	callback = function()
		-- Undo the encryption so the user sees plaintext again
		vim.cmd("silent u")
		vim.opt_local.bin = false
		vim.bo.modified = false
	end,
})
