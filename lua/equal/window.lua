local M = {}

local state = {
	win = nil,
	buf = nil,
}

M.create_scratch_window = function()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_set_current_win(state.win)
	end

	if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
		state.buf = vim.api.nvim_create_buf(false, true)
	end

	local width, height = 120, 30
	local ui = vim.api.nvim_list_uis()[1]

	local window_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = (ui.height - height) / 2,
		col = (ui.width - width) / 2,
	}

	state.win = vim.api.nvim_open_win(state.buf, true, window_opts)
end

M.close_scratch_window = function()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
	end
	state.win = nil
end

M.toggle_scratch_window = function()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		M.close_scratch_window()
	else
		M.create_scratch_window()
	end
end

M.create_repl = function()
	local width, height = 120, 30
	local ui = vim.api.nvim_list_uis()[1]
	local buf = vim.api.nvim_create_buf(false, true)

	local window_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = (ui.height - height) / 2,
		col = (ui.width - width) / 2,
	}

	vim.api.nvim_open_win(buf, true, window_opts)
	vim.fn.jobstart("qalc", {
		term = true,
	})
end

return M
