local utils = require("equal.utils")

local M = {}

M.calc_and_replace = function(expr, range, expanded)
	local output_mode = expanded and "" or "-t"
	if not expr or expr == "" then
		vim.notify("qalc.nvim: empty expression", vim.log.levels.WARN)
		return
	end

	local result = vim.system({ "qalc", output_mode, expr }, { text = true }):wait()

	if result.code ~= 0 then
		vim.notify("qalc: " .. (result.stderr or "error"), vim.log.levels.ERROR)
		return
	end

	local output = result.stdout:gsub("\n$", "")

	if not range then
		local row = vim.api.nvim_win_get_cursor(0)[1] - 1
		vim.api.nvim_buf_set_lines(0, row, row + 1, false, { output })
	else
		local s_row, s_col, e_row, e_col = unpack(range)
		vim.api.nvim_buf_set_text(0, s_row, s_col, e_row, e_col, { output })
	end
end

M.run_calc = function(expanded)
	local text, range = utils.get_visual_selection()
	if not text or text == "" then
		vim.notify("qalc.nvim: empty selection", vim.log.levels.WARN)
		return
	end
	M.calc_and_replace(text, range, expanded)
end

return M
