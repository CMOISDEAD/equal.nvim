local eval = require("equal.eval")
local window = require("equal.window")

local M = {}

local defaults = {
	modes = { "n", "v" },
	keys = {
		calc_replace = "<leader>cc", -- 1 + 2 → 3
		calc_expand = "<leader>cC", -- 1 + 2 → 1 + 2 = 3
		open_repl = "<leader>cr",
		toggle_scratch = "<leader>cs",
	},
}

function M.setup(opts)
	opts = opts or {}

	M.options = vim.tbl_deep_extend("force", defaults, opts)

	vim.keymap.set(M.options.modes, M.options.keys.calc_replace, function()
		eval.run_calc(false)
	end, { silent = true, noremap = true, desc = "Calculate (replace)" })

	vim.keymap.set(M.options.modes, M.options.keys.calc_expand, function()
		eval.run_calc(true)
	end, { silent = true, noremap = true, desc = "Calculate (expanded output)" })

	vim.keymap.set(
		{ "n" },
		M.options.keys.toggle_scratch,
		window.toggle_scratch_window,
		{ silent = true, noremap = true, desc = "Toggle qalc scratch buffer" }
	)

	vim.keymap.set(
		{ "n" },
		M.options.keys.open_repl,
		window.create_repl,
		{ silent = true, noremap = true, desc = "Open qalc repl" }
	)
end

return M
