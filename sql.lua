-- Shared sqruff settings for conform (format) and nvim-lint (lint)
local M = {}

M.config = (os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")) .. "/sqruff/sqruff.cfg"

-- A "-- dialect: postgres" comment in the first 20 lines overrides the tsql default
function M.dialect()
	local dialect = vim.b.sql_dialect or "tsql"
	for i = 1, math.min(20, vim.fn.line("$")) do
		local found = vim.fn.getline(i):match("%-%-%s*dialect:%s*(%w+)")
		if found then
			dialect = found
			break
		end
	end
	return dialect
end

return M
