local M = {}

M.defaults = {
  background = "dark",
  termguicolors = true,

  -- Style knobs are optional, but this keeps things “modern” and user-friendly.
  -- Defaults mirror your original file.
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
  },

  -- Hooks (Tokyonight-style) so users can tweak without forking:
  -- on_colors(colors) -> mutate palette
  on_colors = nil,

  -- on_highlights(hl, colors) -> mutate highlight map before applying
  on_highlights = nil,
}

M.options = vim.deepcopy(M.defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
end

return M
