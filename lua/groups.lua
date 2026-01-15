local M = {}

local function pick_style(styles, key, field, fallback)
  if type(styles) ~= "table" then
    return fallback
  end
  local s = styles[key]
  if type(s) ~= "table" then
    return fallback
  end
  if s[field] == nil then
    return fallback
  end
  return s[field]
end

function M.get(colors, opts)
  opts = opts or {}
  local styles = opts.styles or {}

  local comment_italic = pick_style(styles, "comments", "italic", true)
  local keyword_bold   = pick_style(styles, "keywords", "bold", true)

  local hl = {}

  ---------------------------------------------------------------------
  -- Editor UI
  ---------------------------------------------------------------------
  hl.Normal       = { fg = colors.fg, bg = colors.bg }
  hl.NormalNC     = { fg = colors.fg, bg = colors.bg }
  hl.SignColumn   = { fg = colors.fg, bg = colors.bg }
  hl.EndOfBuffer  = { fg = colors.bg, bg = colors.bg }

  hl.CursorLine   = { bg = colors.bg_highlight }
  hl.CursorLineNr = { fg = colors.type_green, bold = true }
  hl.LineNr       = { fg = colors.gray }

  hl.Visual       = { bg = colors.bg_select }
  hl.MatchParen   = { bg = colors.bg_highlight, bold = true }

  hl.NormalFloat  = { fg = colors.fg, bg = colors.bg_float }
  hl.FloatBorder  = { fg = colors.bg_highlight, bg = colors.bg_float }

  hl.Pmenu        = { fg = colors.fg, bg = colors.bg_float }
  hl.PmenuSel     = { fg = colors.fg, bg = colors.bg_select, bold = true }
  hl.PmenuSbar    = { bg = colors.bg_highlight }
  hl.PmenuThumb   = { bg = colors.gray }

  hl.StatusLine   = { fg = colors.fg, bg = colors.bg_highlight }
  hl.StatusLineNC = { fg = colors.fg_dim, bg = colors.bg }

  hl.WinSeparator = { fg = colors.bg_highlight, bg = colors.bg }
  hl.VertSplit    = { fg = colors.bg_highlight, bg = colors.bg }

  hl.Search       = { fg = colors.bg, bg = colors.meta }
  hl.IncSearch    = { fg = colors.bg, bg = colors.red_soft }
  hl.CurSearch    = { fg = colors.bg, bg = colors.red_soft }

  hl.ErrorMsg     = { fg = colors.red }
  hl.WarningMsg   = { fg = colors.red_soft }

  ---------------------------------------------------------------------
  -- Base Syntax Groups
  ---------------------------------------------------------------------
  hl.Comment     = { fg = colors.gray, italic = comment_italic }

  hl.Keyword     = { fg = colors.purple, bold = keyword_bold }
  hl.Statement   = { fg = colors.purple, bold = keyword_bold }
  hl.Conditional = { fg = colors.purple, bold = keyword_bold }
  hl.Repeat      = { fg = colors.purple, bold = keyword_bold }
  hl.Exception   = { fg = colors.purple, bold = keyword_bold }

  hl.Type        = { fg = colors.type_green }
  hl.Structure   = { fg = colors.type_green }
  hl.Typedef     = { fg = colors.type_green }

  hl.Function    = { fg = colors.blue }
  hl.Identifier  = { fg = colors.fg }

  hl.String      = { fg = colors.green }
  hl.Character   = { fg = colors.green }

  hl.Number      = { fg = colors.red_soft }
  hl.Boolean     = { fg = colors.red_soft }
  hl.Constant    = { fg = colors.red_soft }

  hl.Operator    = { fg = colors.fg }
  hl.Delimiter   = { fg = colors.fg }

  -- Preprocessor should be slate gray
  hl.PreProc     = { fg = colors.fg_dim }
  hl.Include     = { fg = colors.fg_dim }
  hl.Define      = { fg = colors.fg_dim }
  hl.Macro       = { fg = colors.fg_dim }

  ---------------------------------------------------------------------
  -- Tree-sitter Highlight Groups
  ---------------------------------------------------------------------
  hl["@comment"] = { link = "Comment" }

  hl["@keyword"]            = { link = "Keyword" }
  hl["@keyword.type"]       = { link = "Keyword" }
  hl["@keyword.storage"]    = { link = "Keyword" }
  hl["@keyword.modifier"]   = { link = "Keyword" }
  hl["@keyword.function"]   = { link = "Keyword" }
  hl["@keyword.return"]     = { link = "Keyword" }

  hl["@type"]               = { link = "Type" }
  hl["@type.builtin"]       = { link = "Type" }
  hl["@type.qualifier"]     = { link = "Keyword" }
  hl["@namespace"]          = { link = "Type" }

  hl["@function"]           = { link = "Function" }
  hl["@method"]             = { link = "Function" }
  hl["@function.call"]      = { link = "Function" }

  -- Variables
  hl["@variable"]           = { fg = colors.fg }
  hl["@variable.builtin"]   = { fg = colors.red_soft } -- this, etc.

  -- Parameters
  hl["@variable.parameter"]         = { fg = colors.green_param }
  hl["@variable.parameter.builtin"] = { fg = colors.green_param }

  -- Member variables / fields
  hl["@variable.member"]    = { fg = colors.member }
  hl["@field"]              = { fg = colors.member }
  hl["@property"]           = { fg = colors.member }

  -- Constants / macros
  hl["@constant"]           = { link = "Constant" }
  hl["@constant.builtin"]   = { fg = colors.red }
  hl["@constant.macro"]     = { fg = colors.red }

  -- Strings / escapes
  hl["@string"]             = { link = "String" }
  hl["@string.escape"]      = { fg = colors.meta }

  -- Literals
  hl["@number"]             = { link = "Number" }
  hl["@boolean"]            = { link = "Boolean" }

  -- Punctuation
  hl["@punctuation.delimiter"] = { fg = colors.fg }
  hl["@punctuation.bracket"]   = { fg = colors.fg }

  -- Attributes ([[nodiscard]] etc.)
  hl["@attribute"]          = { fg = colors.meta }
  hl["@attribute.builtin"]  = { fg = colors.meta }

  -- Preprocessor captures (some grammars use these)
  hl["@preproc"]            = { fg = colors.fg_dim }
  hl["@include"]            = { fg = colors.fg_dim }
  hl["@define"]             = { fg = colors.fg_dim }
  hl["@macro"]              = { fg = colors.fg_dim }

  -- Many C/C++ queries classify #include/#define as directive keywords
  hl["@keyword.directive"]  = { fg = colors.fg_dim }
  hl["@keyword.import"]     = { fg = colors.fg_dim }

  -- The leading '#' / '##' is often punctuation.special
  hl["@punctuation.special"] = { fg = colors.fg_dim }

  ---------------------------------------------------------------------
  -- LSP Semantic Tokens (Neovim 0.11+/0.12)
  ---------------------------------------------------------------------
  hl["@lsp.type.keyword"]    = { link = "Keyword" }

  hl["@lsp.type.class"]      = { link = "Type" }
  hl["@lsp.type.struct"]     = { link = "Type" }
  hl["@lsp.type.enum"]       = { link = "Type" }
  hl["@lsp.type.namespace"]  = { link = "Type" }

  hl["@lsp.type.function"]   = { link = "Function" }
  hl["@lsp.type.method"]     = { link = "Function" }

  hl["@lsp.type.variable"]   = { fg = colors.fg }
  hl["@lsp.type.parameter"]  = { fg = colors.green_param }
  hl["@lsp.type.enumMember"] = { fg = colors.red_soft }

  -- Member variables
  hl["@lsp.type.property"]              = { fg = colors.member }
  hl["@lsp.typemod.variable.classScope"] = { fg = colors.member }
  hl["@lsp.typemod.property.classScope"] = { fg = colors.member }

  -- Readonly vs mutable
  hl["@lsp.mod.readonly"]               = { italic = true }
  hl["@lsp.typemod.property.readonly"]  = { fg = colors.fg_dim, italic = true }
  hl["@lsp.typemod.variable.readonly"]  = { fg = colors.fg_dim, italic = true }
  hl["@lsp.typemod.parameter.readonly"] = { italic = true }

  -- Static distinction
  hl["@lsp.mod.static"]                 = { bold = true }

  -- Deprecated distinction
  hl["@lsp.mod.deprecated"]             = { strikethrough = true }

  -- Attributes via LSP
  hl["@lsp.type.decorator"]             = { fg = colors.meta }
  hl["@lsp.type.attribute"]             = { fg = colors.meta }

  ---------------------------------------------------------------------
  -- Diagnostics (incl. unused fade)
  ---------------------------------------------------------------------
  hl.DiagnosticError = { fg = colors.red }
  hl.DiagnosticWarn  = { fg = colors.red_soft }
  hl.DiagnosticInfo  = { fg = colors.green }
  hl.DiagnosticHint  = { fg = colors.teal }

  hl.DiagnosticUnderlineError = { sp = colors.red, undercurl = true }
  hl.DiagnosticUnderlineWarn  = { sp = colors.red_soft, undercurl = true }
  hl.DiagnosticUnderlineInfo  = { sp = colors.green, undercurl = true }
  hl.DiagnosticUnderlineHint  = { sp = colors.teal, undercurl = true }

  hl.DiagnosticUnnecessary = { fg = colors.fg_dim }
  hl.DiagnosticDeprecated  = { fg = colors.fg_dim, strikethrough = true }

  hl.DiagnosticSignError = { fg = colors.red, bg = colors.bg }
  hl.DiagnosticSignWarn  = { fg = colors.red_soft, bg = colors.bg }
  hl.DiagnosticSignInfo  = { fg = colors.green, bg = colors.bg }
  hl.DiagnosticSignHint  = { fg = colors.teal, bg = colors.bg }

  hl.LspInlayHint                 = { fg = colors.fg_dim, bg = colors.bg }
  hl.LspSignatureActiveParameter  = { fg = colors.bg, bg = colors.green_param, bold = true }

  ---------------------------------------------------------------------
  -- Telescope (safe even if Telescope not installed)
  ---------------------------------------------------------------------
  hl.TelescopeNormal    = { fg = colors.fg, bg = colors.bg_float }
  hl.TelescopeBorder    = { fg = colors.bg_highlight, bg = colors.bg_float }
  hl.TelescopeSelection = { bg = colors.bg_select, bold = true }
  hl.TelescopeMatching  = { fg = colors.red_soft, bold = true }

  ---------------------------------------------------------------------
  -- nvim-cmp (safe even if not installed)
  ---------------------------------------------------------------------
  hl.CmpItemAbbr           = { fg = colors.fg }
  hl.CmpItemAbbrMatch      = { fg = colors.red_soft, bold = true }
  hl.CmpItemAbbrMatchFuzzy = { fg = colors.red_soft, bold = true }
  hl.CmpItemMenu           = { fg = colors.fg_dim }

  hl.CmpItemKindFunction   = { fg = colors.blue }
  hl.CmpItemKindMethod     = { fg = colors.blue }
  hl.CmpItemKindVariable   = { fg = colors.green_param }
  hl.CmpItemKindField      = { fg = colors.member }
  hl.CmpItemKindProperty   = { fg = colors.member }
  hl.CmpItemKindClass      = { fg = colors.type_green }
  hl.CmpItemKindKeyword    = { fg = colors.purple }

  ---------------------------------------------------------------------
  -- Legacy Vim C/C++ syntax fallback (regex highlighting)
  ---------------------------------------------------------------------
  hl.cppStructure    = { link = "Keyword" }
  hl.cppStorageClass = { link = "Keyword" }
  hl.cppModifier     = { link = "Keyword" }
  hl.cppStatement    = { link = "Keyword" }

  hl.cStructure      = { link = "Keyword" }
  hl.cStorageClass   = { link = "Keyword" }
  hl.cStatement      = { link = "Keyword" }

  -- If regex attribute groups ever reappear, keep them consistent:
  hl.cBlock          = { fg = colors.meta }
  hl.cBracket        = { fg = colors.meta }

  return hl
end

return M
