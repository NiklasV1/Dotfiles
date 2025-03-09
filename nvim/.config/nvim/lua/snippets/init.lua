-- NOTE: Setup snippets
local ls = require("luasnip")

-- Angular snippets
local angular_snippets = require("snippets.angular")
ls.add_snippets("typescript", angular_snippets)

-- JSON snippets
local json_snippets = require("snippets.json")
ls.add_snippets("json", json_snippets)
