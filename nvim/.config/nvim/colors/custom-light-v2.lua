-- Reset colors
vim.cmd("highlight clear")
vim.opt.background = "light"
vim.g.colors_name = "custom-light-v2"

---@param name string
---@param val vim.api.keyset.highlight
local hl = function(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

local colors = {
	gray050 = "#FAF9F7",
	gray100 = "#E8E6E1",
	gray200 = "#D3CEC4",
	gray300 = "#B8B2A7",
	gray400 = "#A39E93",
	gray500 = "#857F72",
	gray600 = "#625D52",
	gray700 = "#504A40",
	gray800 = "#423D33",
	gray900 = "#27241D",
	blue050 = "#E0E8F9",
	blue100 = "#BED0F7",
	blue200 = "#98AEEB",
	blue300 = "#7B93DB",
	blue400 = "#647ACB",
	blue500 = "#4C63B6",
	blue600 = "#4055A8",
	blue700 = "#35469C",
	blue800 = "#2D3A8C",
	blue900 = "#19216C",
	green050 = "#E3F9E5",
	green100 = "#C1EAC5",
	green200 = "#A3D9A5",
	green300 = "#7BC47F",
	green400 = "#57AE5B",
	green500 = "#3F9142",
	green600 = "#2F8132",
	green700 = "#207227",
	green800 = "#0E5814",
	green900 = "#05400A",
	red050 = "#FFE3E3",
	red100 = "#FFBDBD",
	red200 = "#FF9B9B",
	red300 = "#F86A6A",
	red400 = "#EF4E4E",
	red500 = "#E12D39",
	red600 = "#CF1124",
	red700 = "#AB091E",
	red800 = "#8A041A",
	red900 = "#610316",
	purple050 = "#F2EBFE",
	purple100 = "#DAC4FF",
	purple200 = "#B990FF",
	purple300 = "#A368FC",
	purple400 = "#9446ED",
	purple500 = "#8719E0",
	purple600 = "#7A0ECC",
	purple700 = "#690CB0",
	purple800 = "#580A94",
	purple900 = "#44056E",
	yellow050 = "#FFFBEA",
	yellow100 = "#FFF3C4",
	yellow150 = "#FEEFB3",
	yellow200 = "#FCE588",
	yellow300 = "#FADB5F",
	yellow400 = "#F7C948",
	yellow500 = "#F0B429",
	yellow600 = "#DE911D",
	yellow700 = "#CB6E17",
	yellow800 = "#B44D12",
	yellow900 = "#8D2B0B",
}

-- Editor interface
hl("Normal", { bg = colors.gray050, fg = colors.gray900 })
hl("NormalNC", { link = "Normal" })
hl("NormalFloat", { link = "Normal" })

hl("Cursor", { bg = colors.gray900, fg = colors.gray050 })
hl("CursorLine", { bg = colors.gray100 })

hl("Visual", { bg = colors.blue050 })
hl("VisualNOS", { link = "Visual" })

hl("WinSeparator", { link = "Normal" })
hl("VertSplit", { link = "WinSeparator" })

hl("SignColumn", { fg = colors.gray500 })
hl("LineNr", { fg = colors.gray500 })
hl("CursorLineNr", { fg = colors.gray900, bold = true })

hl("Search", { bg = colors.yellow150 })
hl("CurSearch", { bg = colors.yellow300, fg = colors.gray900 })
hl("IncSearch", { link = "CurSearch" })

hl("MatchParen", { fg = colors.gray900, bg = colors.blue100 })

hl("ModeMsg", { fg = colors.gray900 })
hl("OkMsg", { fg = colors.gray900 })
hl("MoreMsg", { fg = colors.gray900 })
hl("WarningMsg", { fg = colors.yellow600, bold = true })
hl("ErrorMsg", { fg = colors.red500, bold = true })

hl("FloatBorder", { link = "NormalFloat" })
hl("FloatShadow", { bg = colors.gray500 })
hl("FloatShadowThrough", { link = "FloatShadow" })

hl("NonText", { fg = colors.gray400 })
hl("SpecialKey", { link = "NonText" })

hl("Pmenu", { fg = colors.gray900, bg = colors.gray200 })
hl("PmenuSel", { fg = colors.gray050, bg = colors.gray900 })
hl("PmenuSbar", { fg = colors.gray900, bg = colors.gray300 })

hl("StatusLine", { fg = colors.gray900, bg = colors.gray200 })
hl("StatusLineNC", { link = "StatusLine" })
hl("StatusLineAlt", { fg = colors.gray050, bg = colors.gray800 })

hl("CmpItemKindDefault", { fg = colors.blue700 })
hl("Question", { fg = colors.gray900 })
hl("Title", { fg = colors.gray900, bold = true })
hl("TabLineSel", { fg = colors.gray900, bg = colors.gray050, bold = true })
hl("Directory", { fg = colors.gray900 })

-- Git
hl("DiffAdd", { fg = colors.gray900, bg = colors.green100 })
hl("DiffChange", { fg = colors.gray900, bg = colors.blue100 })
hl("DiffDelete", { fg = colors.gray900, bg = colors.red100 })
hl("Added", { fg = colors.green600 })
hl("Changed", { fg = colors.blue600 })
hl("Removed", { fg = colors.red600 })
hl("GitSignsDeleteInline", { fg = colors.gray900, bg = colors.red200 })
hl("GitSignsAddInline", { fg = colors.gray900, bg = colors.green200 })
hl("NeoTreeGitModified", { fg = colors.blue600 })

-- Diagnostics
hl("DiagnosticUnnecessary", { fg = colors.gray500 })
hl("DiagnosticInfo", { fg = colors.gray600 })
hl("DiagnosticOk", { fg = colors.green700 })
hl("DiagnosticHint", { fg = colors.blue600 })
hl("DiagnosticWarn", { link = "WarningMsg" })
hl("DiagnosticError", { link = "ErrorMsg" })

-- Syntax Groups
hl("Comment", { fg = colors.red800 })
hl("SpecialComment", { fg = colors.red600 })
hl("Todo", { fg = colors.red600 })
hl("Error", { fg = colors.red600 })
hl("String", { fg = colors.green700 })
hl("Character", { link = "String" })
hl("Constant", { fg = colors.purple800 })
hl("Number", { link = "Constant" })
hl("Boolean", { link = "Constant" })
hl("Float", { link = "Number" })
hl("Delimiter", { fg = colors.gray500 })
hl("Function", { fg = colors.blue800 })
hl("Identifier", { fg = colors.blue800 })
hl("Type", { fg = colors.yellow800 })
hl("Special", { fg = colors.yellow800 })
hl("Statement", { fg = colors.gray900 })
hl("Operator", { link = "Statement" })
hl("Keyword", { link = "Statement" })
hl("Exception", { link = "Statement" })
hl("Conditional", { fg = colors.gray900 })
hl("Repeat", { link = "Conditional" })
hl("Label", { link = "Conditional" })

-- Typescript
hl("@keyword.jsdoc", { link = "SpecialComment" })
hl("@variable.member.typescript", { link = "Identifier" })
-- TODO: Increase priority for treesitter constant group

-- HTML
hl("@tag.html", { link = "Identifier" })
hl("@tag.delimiter.html", { link = "Delimiter" })

-- Angular
hl("@tag.angular", { link = "@tag.html" })
hl("@tag.delimiter.angular", { link = "@tag.delimiter.html" })

-- Markdown
hl("@markup.list.checked", { fg = colors.gray900, bg = colors.green200 })
hl("@markup.list.unchecked", { fg = colors.gray900, bg = colors.red200 })

hl("@constructor.lua", { link = "Delimiter" })
