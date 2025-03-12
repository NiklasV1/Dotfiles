-- NOTE: Typescript snippets

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
	-- Console log
	-- TODO: Fix error
	-- s("log", {
	-- 	fmt("console.log('{name}: ', {value});", {
	-- 		name = i(1, "name"),
	-- 		value = i(2, "value"),
	-- 	}),
	-- }),
}
