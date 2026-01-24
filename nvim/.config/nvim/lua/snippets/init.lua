local ls = require("luasnip")

-- Angular snippets
ls.add_snippets("typescript", require("snippets.angular"))

-- Typescript snippets
ls.add_snippets("typescript", require("snippets.typescript"))

-- JSON snippets
ls.add_snippets("json", require("snippets.json"))

-- Go snippets
ls.add_snippets("go", require("snippets.go"))
