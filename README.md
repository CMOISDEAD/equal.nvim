# equal.nvim

https://github.com/user-attachments/assets/e4da227f-d296-4f3a-a4bb-b8a0d95b3389

<p align="center">equal.nvim — evaluate math in place. seamless. fast. qalc-powered</p>

## Description

Neovim plugin for evaluating math expressions using qalc.

## Features

- Evaluate expressions (normal + visual mode)
- Floating qalc REPL
- Floating scratch pad
- Terse / expanded output modes

## Installation

- Lazy (default options)

```lua
{
  "CMOISDEAD/equal.nvim",
  config = function()
    require('equal').setup {
      modes = { "n", "v" },
      keys = {
        calc_replace = "<leader>cc", -- 1 + 2 → 3
        calc_expand = "<leader>cC", -- 1 + 2 → 1 + 2 = 3
        open_repl = "<leader>cr",
        toggle_scratch = "<leader>cs",
      },
    }
  end
}
```

## Roadmap

- Multiline evaluation
- Unit conversions (cm -> m)
- UI improvements
