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
	s("cons", {
		t("console.log("),
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
}
