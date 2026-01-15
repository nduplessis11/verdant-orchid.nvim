local M = {}

local config  = require("verdantorchid.config")
local palette = require("verdantorchid.palette")
local groups  = require("verdantorchid.groups")
local util    = require("verdantorchid.util")

function M.setup(opts)
  config.setup(opts)
end

function M.load(opts)
  if opts ~= nil then
    M.setup(opts)
  end

  local o = config.options

  -- This mirrors classic colorscheme behavior while staying Lua-native.
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.background = o.background or "dark"

  if o.termguicolors then
    vim.o.termguicolors = true
  end

  vim.g.colors_name = "verdant_orchid"

  local colors = palette.get()
  if type(o.on_colors) == "function" then
    o.on_colors(colors)
  end

  local hl = groups.get(colors, o)
  if type(o.on_highlights) == "function" then
    o.on_highlights(hl, colors)
  end

  util.apply(hl)
end

return M
