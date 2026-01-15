# verdantorchid.nvim

**Verdant Orchid** — dark, vibrant green + purple Neovim colorscheme.

- Tree-sitter highlight groups (`@...`)
- LSP semantic token groups (`@lsp...`)
- Diagnostics groups
- Telescope + nvim-cmp highlight groups (safe to define even if not installed)

## Requirements

- Neovim 0.11+ recommended (for modern LSP/semantic tokens usage)
- For native installation with `vim.pack.add()`: Neovim 0.12+ / nightly (vim.pack is documented as experimental)  

## Install (native Neovim package manager)

In your `init.lua`:

```lua
vim.pack.add({
  -- Any of these forms are supported by vim.pack:
  "https://github.com/YOUR_GITHUB_USER/verdantorchid.nvim",
  -- or:
  -- { src = "https://github.com/YOUR_GITHUB_USER/verdantorchid.nvim" },
})

-- Optional config (must run before :colorscheme)
require("verdantorchid").setup({
  -- on_colors = function(c) ... end,
  -- on_highlights = function(hl, c) ... end,
})

vim.cmd.colorscheme("verdant_orchid")

vim.pack.add() installs and makes the plugin reachable immediately; plugins are managed under a dedicated vim.pack directory and tracked with a lockfile. See :help vim.pack for details.

## Usage

- `:colorscheme verdant_orchid`

To tweak without forking, use:

```lua
require("verdantorchid").setup({
  on_colors = function(c)
    -- Example: slightly dim the main fg
    -- c.fg = "#d0d0d0"
  end,
  on_highlights = function(hl, c)
    -- Example: make LineNr brighter
    -- hl.LineNr = { fg = c.fg_dim }
  end,
})
```

## Notes on "integrations"

This theme does not call Telescope/Tree-sitter/LSP APIs.
It only defines highlight groups those systems already use.
That’s the standard, low-surprise approach for theme plugins.

