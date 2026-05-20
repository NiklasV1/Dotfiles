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
	-- Console log: console.log('x', x)
	s("cons", {
		t("console.log('"),
		f(function(args)
			return args[1][1]
		end, { 1 }),
		t("', "),
		i(1, "value"),
		t(");"),
	}),

	s(
		"apierr",
		fmt(
			[[
		throw ApiError.|errorType/([
			{
				id: |id/,
				message: |message/,
			},
		]);
		]],
			{
				errorType = i(1, "errorType"),
				id = i(2, "id"),
				message = i(3, "message"),
			},
			{ delimiters = "|/" }
		)
	),

	-- Arrow function
	s(
		"af",
		fmt([[(|args/) => { |body/ }]], {
			args = i(1, "args"),
			body = i(0),
		}, { delimiters = "|/" })
	),

	-- Method definition
	s(
		"meth",
		fmt(
			[[|name/(|arg/: |argType/): |returnType/ {
	|body/
}]],
			{
				name = i(1, "methodName"),
				arg = i(2, "arg"),
				argType = i(3, "ArgType"),
				returnType = i(4, "ReturnType"),
				body = i(0),
			},
			{ delimiters = "|/" }
		)
	),

	-- Type definition
	s(
		"type",
		fmt(
			[[type |name/ = {
	|field/: |fieldType/;
}]],
			{
				name = i(1, "Name"),
				field = i(2, "field"),
				fieldType = i(3, "FieldType"),
			},
			{ delimiters = "|/" }
		)
	),

	-- Enum definition
	s(
		"enum",
		fmt(
			[[enum |name/ {
	|value/,
}]],
			{
				name = i(1, "Name"),
				value = i(2, "VALUE"),
			},
			{ delimiters = "|/" }
		)
	),

	-- ICONS const definition
	s(
		"icons",
		fmt(
			[[protected readonly ICONS = {
	|body/
} as const;]],
			{
				body = i(0),
			},
			{ delimiters = "|/" }
		)
	),

	-- try/catch block
	s(
		"tryc",
		fmt(
			[[try {
	|body/
} catch (|err/) {
	|handler/
}]],
			{
				body = i(1),
				err = i(2, "err"),
				handler = i(0),
			},
			{ delimiters = "|/" }
		)
	),
}
