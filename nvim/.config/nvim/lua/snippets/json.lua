-- NOTE: JSON snippets

local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node

return {
	s(
		"translation",
		fmt('"{key}": "{translation}",', {
			key = i(1, "key"),
			translation = i(2, "translation"),
		})
	),
}
