local M = {}

function M.apply(highlights)
  -- Deterministic application (useful when debugging).
  local keys = vim.tbl_keys(highlights)
  table.sort(keys)

  for _, group in ipairs(keys) do
    vim.api.nvim_set_hl(0, group, highlights[group])
  end
end

return M
