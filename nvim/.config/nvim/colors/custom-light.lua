-- Reset colors
vim.cmd("highlight clear")
vim.opt.background = "light"
vim.g.colors_name = "custom-light"

---@param name string
---@param val vim.api.keyset.highlight
local hl = function(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

local colors = {
	yellow50 = "#fffbdb",
	yellow100 = "#fff7bd",
	yellow150 = "#fff399",
	yellow200 = "#ffef75",
	yellow300 = "#ffe733",
	yellow400 = "#efd500",
	yellow500 = "#c7b000",
	yellow600 = "#9e8c00",
	yellow700 = "#756800",
	yellow800 = "#524800",
	yellow900 = "#292400",
	yellow950 = "#141200",
	darkgreen50 = "#ebf5f2",
	darkgreen100 = "#d3eee6",
	darkgreen200 = "#a0e3d0",
	darkgreen300 = "#68dfbd",
	darkgreen400 = "#26dfaa",
	darkgreen500 = "#12b587",
	darkgreen600 = "#08825f",
	darkgreen700 = "#004c37",
	darkgreen800 = "#033023",
	darkgreen900 = "#021711",
	darkgreen950 = "#010907",
	darkdarkgreen50 = "#edf3f1",
	darkdarkgreen100 = "#daece6",
	darkdarkgreen200 = "#aee0d0",
	darkdarkgreen300 = "#79d8ba",
	darkdarkgreen400 = "#42d7a8",
	darkdarkgreen500 = "#1dc38f",
	darkdarkgreen600 = "#0f996d",
	darkdarkgreen700 = "#066a4a",
	darkdarkgreen800 = "#003625",
	darkdarkgreen900 = "#011811",
	darkdarkgreen950 = "#010e0a",
	green50 = "#f3fae5",
	green100 = "#e9f6d0",
	green200 = "#d2eda1",
	green300 = "#bce372",
	green400 = "#a3d93f",
	green500 = "#87bd25",
	green600 = "#6b951d",
	green700 = "#537317",
	green800 = "#374d0f",
	green900 = "#1c2608",
	green950 = "#0c1103",
	softgreen50 = "#f2f6ef",
	softgreen100 = "#e3ebdb",
	softgreen200 = "#c8d7b7",
	softgreen300 = "#afc596",
	softgreen400 = "#98b479",
	softgreen500 = "#7fa159",
	softgreen600 = "#658047",
	softgreen700 = "#4b5f35",
	softgreen800 = "#344224",
	softgreen900 = "#1a2112",
	softgreen950 = "#0d1009",
	darksage50 = "#f1f4f1",
	darksage100 = "#e2e9e3",
	darksage200 = "#c2d1c4",
	darksage300 = "#a5baa8",
	darksage400 = "#89a48b",
	darksage500 = "#6c8e70",
	darksage600 = "#546e57",
	darksage700 = "#3e5140",
	darksage800 = "#2a372b",
	darksage900 = "#141a15",
	darksage950 = "#0b0e0b",
	lightblue50 = "#eff4fa",
	lightblue100 = "#e0e8f6",
	lightblue200 = "#c4d4ed",
	lightblue300 = "#a4bde4",
	lightblue400 = "#799dd7",
	lightblue500 = "#4e7eca",
	lightblue600 = "#3362ad",
	lightblue700 = "#274a82",
	lightblue800 = "#1a3157",
	lightblue900 = "#0d192b",
	lightblue950 = "#060b14",
	lavender50 = "#f4f2f8",
	lavender100 = "#eae5f1",
	lavender200 = "#d5cae2",
	lavender300 = "#bdadd2",
	lavender400 = "#a892c3",
	lavender500 = "#9278b5",
	lavender600 = "#73559b",
	lavender700 = "#563f73",
	lavender800 = "#3b2b4f",
	lavender900 = "#1d1628",
	lavender950 = "#0f0b14",
	alert50 = "#ffe5e8",
	alert100 = "#ffccd1",
	alert200 = "#ff9ea8",
	alert300 = "#ff6b7a",
	alert400 = "#ff3d51",
	alert500 = "#ff0a23",
	alert600 = "#db0016",
	alert700 = "#a30010",
	alert800 = "#6b000b",
	alert900 = "#380006",
	alert950 = "#190003",
	thulian50 = "#fdedf2",
	thulian100 = "#fbdfe8",
	thulian200 = "#f6bbcd",
	thulian300 = "#f29db7",
	thulian400 = "#eb6a91",
	thulian500 = "#e5396c",
	thulian600 = "#cb1b50",
	thulian700 = "#99143c",
	thulian800 = "#630d27",
	thulian900 = "#320713",
	thulian950 = "#1b040b",
	softthulian50 = "#f8eeed",
	softthulian100 = "#f0dad8",
	softthulian200 = "#e1b6b2",
	softthulian300 = "#d49691",
	softthulian400 = "#c6736c",
	softthulian500 = "#b85047",
	softthulian600 = "#934039",
	softthulian700 = "#6e302b",
	softthulian800 = "#4a201c",
	softthulian900 = "#25100e",
	softthulian950 = "#120807",
	gray50 = "#f5f5f5",
	gray100 = "#eeeeee",
	gray200 = "#d6d6d6",
	gray300 = "#bcbcbc",
	gray400 = "#a4a4a4",
	gray500 = "#8b8b8b",
	gray600 = "#6e6e6e",
	gray700 = "#535353",
	gray800 = "#393939",
	gray900 = "#1b1b1b",
	gray950 = "#0d0d0d",
	black = "#000000",
	white = "#ffffff",
}

-- Editor interface
hl("Normal", { bg = colors.white, fg = colors.black })
hl("NormalNC", { link = "Normal" })
hl("NormalFloat", { link = "Normal" })
hl("Cursor", { bg = colors.black, fg = colors.white })
hl("CursorLine", { bg = colors.gray200 })
hl("Visual", { bg = colors.lightblue100 })
hl("VisualNOS", { link = "Visual" })
hl("WinSeparator", { link = "Normal" })
hl("VertSplit", { link = "WinSeparator" })
hl("SignColumn", { fg = colors.gray400 })
hl("LineNr", { fg = colors.gray400 })
hl("Search", { bg = colors.yellow150 })
hl("CurSearch", { bg = colors.yellow300, fg = colors.black })
hl("IncSearch", { link = "CurSearch" })
hl("CursorLineNr", { fg = colors.black, bold = true })
hl("MatchParen", { fg = colors.white, bg = colors.gray600 })
hl("ModeMsg", { fg = colors.black })
hl("OkMsg", { fg = colors.black })
hl("WarningMsg", { fg = colors.yellow500 })
hl("ErrorMsg", { fg = colors.alert600 })
hl("MoreMsg", { fg = colors.black })
hl("FloatBorder", { link = "NormalFloat" })
hl("FloatShadow", { bg = colors.gray500 })
hl("FloatShadowThrough", { link = "FloatShadow" })
hl("NonText", { fg = colors.gray400 })
hl("Pmenu", { fg = colors.black, bg = colors.gray200 })
hl("PmenuSel", { fg = colors.white, bg = colors.black })
hl("PmenuSbar", { link = "Pmenu" })
hl("PmenuSbar", { fg = colors.black, bg = colors.gray300 })
hl("Question", { fg = colors.black })
hl("SpecialKey", { link = "NonText" })
hl("StatusLine", { fg = colors.white, bg = colors.darkgreen700 })
hl("StatusLineNC", { link = "StatusLine" })
hl("CmpItemKindDefault", { fg = colors.darkgreen700 })
hl("Title", { fg = colors.black, bold = true })
hl("TabLineSel", { fg = colors.black, bg = colors.white, bold = true })

-- Git
hl("DiffAdd", { fg = colors.black, bg = colors.green200 })
hl("DiffChange", { fg = colors.black, bg = colors.yellow150 })
hl("DiffDelete", { fg = colors.black, bg = colors.alert100 })
hl("Added", { fg = colors.green700 })
hl("Changed", { fg = colors.yellow500 })
hl("Removed", { fg = colors.alert700 })

-- Diagnostics
hl("DiagnosticUnnecessary", { fg = colors.gray500 })
hl("DiagnosticInfo", { fg = colors.gray600 })
hl("DiagnosticOk", { fg = colors.darkgreen700 })
hl("DiagnosticHint", { fg = colors.lightblue600 })
hl("DiagnosticWarn", { link = "WarningMsg" })
hl("DiagnosticError", { link = "ErrorMsg" })

-- Syntax Groups
hl("Comment", { fg = colors.softthulian500 })
hl("SpecialComment", { fg = colors.alert600 })
hl("Todo", { fg = colors.alert600 })
hl("Error", { fg = colors.alert600 })
hl("String", { fg = colors.green700 })
hl("Character", { link = "String" })
hl("Number", { fg = colors.lavender600 })
hl("Float", { link = "Number" })
hl("Boolean", { fg = colors.lavender600 })
hl("Delimiter", { fg = colors.gray400 })
hl("Constant", { fg = colors.softthulian600 })
hl("Function", { fg = colors.lightblue600 })
hl("Identifier", { fg = colors.lightblue600 })
hl("Type", { fg = colors.softthulian600 })
hl("Special", { fg = colors.softthulian600 })
hl("@tag.html", { fg = colors.lightblue600 })
hl("@tag.delimiter.html", { link = "Delimiter" })
hl("Statement", { fg = colors.black })
hl("Operator", { link = "Statement" })
hl("Keyword", { link = "Statement" })
hl("Exception", { link = "Statement" })
hl("Conditional", { fg = colors.black })
hl("Repeat", { link = "Conditional" })
hl("Label", { link = "Conditional" })
