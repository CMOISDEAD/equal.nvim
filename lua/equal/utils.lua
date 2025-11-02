local M = {}

M.get_visual_selection = function()
	local mode = vim.fn.mode()

	-- Modo normal: línea actual
	if not (mode == 'v' or mode == 'V' or mode == '\22') then
		local row = vim.api.nvim_win_get_cursor(0)[1] - 1
		local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ''
		return line, { row, 0, row, #line }
	end

	-- Forzar actualización de marcas visuales
	vim.cmd 'normal! gv'

	local start_pos = vim.fn.getpos "'<"
	local end_pos = vim.fn.getpos "'>"

	local s_row = start_pos[2] - 1
	local s_col = start_pos[3] - 1
	local e_row = end_pos[2] - 1
	local e_col = end_pos[3] - 1 -- inclusivo

	-- Normalizar si selección invertida
	if e_row < s_row or (e_row == s_row and e_col < s_col) then
		s_row, e_row = e_row, s_row
		s_col, e_col = e_col, s_col
	end

	-- Ajustar e_col: debe ser exclusivo
	-- Si e_col == 0 → línea vacía
	-- Si e_col > 0 → +1 para exclusivo
	local line = vim.api.nvim_buf_get_lines(0, e_row, e_row + 1, false)[1] or ''
	local line_len = #line

	-- Si el cursor está al final de la línea, e_col = line_len
	-- → end_col exclusivo = line_len (no +1)
	local end_col_exclusive = (e_col == 0) and 0 or math.min(e_col + 1, line_len + 1)

	-- Validación final: evitar start_col > end_col
	if s_row > e_row then
		return '', nil
	end
	if s_row == e_row and s_col >= end_col_exclusive then
		return '', nil
	end

	-- Extraer texto
	local lines = vim.api.nvim_buf_get_text(0, s_row, s_col, e_row, end_col_exclusive, {})
	local text = table.concat(lines, '\n')

	-- Rango para reemplazo
	local range = { s_row, s_col, e_row, end_col_exclusive }

	return text, range
end

return M
