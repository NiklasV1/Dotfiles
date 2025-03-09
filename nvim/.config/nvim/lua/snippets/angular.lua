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
	-- Services
	s(
		"ng-service",
		fmt("readonly #{name} = inject({service});", {
			name = i(1, "name"),
			service = i(2, "service"),
		})
	),

	-- In/Outputs
	s(
		"ng-input",
		fmt("public readonly {name} = input<{type}>();", {
			name = i(1, "name"),
			type = i(2, "type"),
		})
	),

	-- Forms
	s("ng-form-builder", {
		c(1, {
			t("readonly #formBuilder = inject(FormBuilder);"),
			t("readonly #formBuilderNonNullable = inject(NonNullableFormBuilder);"),
		}),
	}),
	s("ng-form", {
		c(1, {
			fmt("protected readonly {name} = this.{builder}.{kind}<{type}>({value});", {
				name = i(1, "name"),
				builder = c(2, {
					t("#formBuilder"),
					t("#formBuilderNonNullable"),
					i("builder"),
				}),
				kind = c(3, {
					t("control"),
					t("group"),
					t("record"),
					t("array"),
				}),
				type = i(4, "type"),
				value = i(5, "value"),
			}),
			fmt("protected readonly {name} = {kind}<{type}>({value});", {
				name = i(1, "name"),
				kind = c(2, {
					t("FormControl"),
					t("FormGroup"),
					t("FormRecord"),
					t("FormArray"),
				}),
				type = i(3, "type"),
				value = i(4, "value"),
			}),
			fmt("{name}: [{value}],", {
				name = i(1, "name"),
				value = i(2, "value"),
			}),
		}),
	}),

	-- Signals
	s(
		"ng-signal",
		fmt("protected readonly {name} = signal<{type}>({value});", {
			name = i(1, "name"),
			type = i(2, "type"),
			value = i(3, "value"),
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
