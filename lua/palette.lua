local M = {}

-- Palette: ONLY colors present in PLAYPAL.pal (VioletShift), palette 0
-- (Avoids yellow entirely)
M.base = {
  -- Backgrounds (deep violet family)
  bg           = "#1b0228",
  bg_float     = "#210233",
  bg_highlight = "#2e0347",
  bg_select    = "#340352",

  -- Foregrounds / grays
  fg           = "#dfdfdf",
  fg_dim       = "#979797",
  gray         = "#4b4b4b",

  -- Syntax anchors
  purple       = "#960bea", -- keywords
  purple_dim   = "#7609b7", -- secondary purple

  blue         = "#7171e3", -- functions
  green        = "#67df5f", -- strings
  type_green   = "#5bbf4f", -- types (green-ish, not yellow)
  teal         = "#53af47", -- hints / subtle green

  -- Values / alerts
  red          = "#ff0000", -- errors
  red_soft     = "#ff5f5f", -- numbers / enum members / matching

  -- Semantic separation
  green_param  = "#77ff6f", -- parameters
  meta         = "#deaefb", -- attributes / escapes / meta
  member       = "#ffb7b7", -- member variables (stands out; not keyword-purple)
}

function M.get()
  return vim.deepcopy(M.base)
end

return M
