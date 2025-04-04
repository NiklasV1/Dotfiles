-- NOTE: Setup snippets
local ls = require("luasnip")

-- Angular snippets
local angular_snippets = require("snippets.angular")
ls.add_snippets("typescript", angular_snippets)

-- Typescript snippets
local typescript_snippets = require("snippets.typescript")
ls.add_snippets("typescript", typescript_snippets)

-- JSON snippets
local json_snippets = require("snippets.json")
ls.add_snippets("json", json_snippets)

-- Go snippets
local go_snippets = require("snippets.go")
ls.add_snippets("go", go_snippets)
