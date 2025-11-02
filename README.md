# equal.nvim

https://github.com/user-attachments/assets/e4da227f-d296-4f3a-a4bb-b8a0d95b3389

<p align="center">equal.nvim — evaluate math in place. seamless. fast. qalc-powered</p>

## Description

Neovim plugin for evaluating math expressions using qalc.

## Requirements

- [qalc](https://github.com/Qalculate/libqalculate)

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

## Usage

- `:Equal` Calculate line/visual expressions
- `:EqualExpanded` Calculate with expanded otput mode
- `:EqualScratch` Toggle qalc scratch buffer
- `:EqualRepl` Open qalc repl

## Roadmap

- Multiline evaluation
- UI improvements
- Real-time values
