# verdant-orchid.nvim

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
  { src = "https://github.com/nduplessis11/verdant-orchid.nvim" },
})

-- Optional config (must run before :colorscheme)
require("verdant-orchid").setup({
  -- on_colors = function(c) ... end,
  -- on_highlights = function(hl, c) ... end,
})

vim.cmd.colorscheme("verdant-orchid")
```
