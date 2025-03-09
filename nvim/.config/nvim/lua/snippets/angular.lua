-- NOTE: Angular snippets

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node

return {
	s({ trig = "ng-signal", dscr = "signal definition" }, {
		t("protected readonly "),
		i(1, { "name" }),
		t(" = signal<"),
		i(2, { "type" }),
		t(">("),
		i(3, { "value" }),
		t(");"),
	}),
}
