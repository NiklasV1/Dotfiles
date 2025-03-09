-- NOTE: Angular snippets

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
		"ng-signal",
		fmt("protected readonly {name} = signal<{type}>({value});", {
			name = i(1, "name"),
			type = i(2, "type"),
			value = i(3, "value"),
		})
	),
	s(
		"ng-input",
		fmt("public readonly {name} = input<{type}>();", {
			name = i(1, "name"),
			type = i(2, "type"),
		})
	),
	s(
		"ng-inject",
		fmt("readonly #{name} = inject({service});", {
			name = i(1, "name"),
			service = i(2, "service"),
		})
	),
	s(
		"ng-computed",
		fmt(
			[[
		protected readonly |name/ = computed<|type/>(() => {
			|body/
		});
		]],
			{
				name = i(1, "name"),
				type = i(2, "type"),
				body = i(3, "body"),
			},
			{ delimiters = "|/" }
		)
	),
}
