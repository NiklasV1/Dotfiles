-- Basic settings
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = false -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 20 -- Keep 10 lines above/below cursor
vim.opt.wrap = false -- Don't wrap lines
vim.opt.sidescrolloff = 8 -- Keep 8 cols shown
vim.opt.breakindent = true -- Indent wrapped lines

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show matches as you type

-- Visual settings
-- vim.cmd.colorscheme("default") -- Colorscheme
-- vim.cmd("set background=dark") -- Dark mode
-- vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#ffffff", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewLine", { fg = "#ffffff", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "Visual", { bg = "#404040" })
vim.cmd.colorscheme("custom-light") -- Colorscheme
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.g.have_nerd_font = true -- Enable nerd font
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.showmode = true -- Show mode in command line
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 0 -- Popup menu transparency | 0 = opaque
vim.opt.winblend = 0 -- Floating window transparency | 0 = opaque
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- Don't hide cursor line markup
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.list = false -- Don't show special characters like tab
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- chars to replace special characters with
vim.opt.inccommand = "split" -- Preview substitutions
vim.opt.winborder = "single" -- Window borders
vim.opt.laststatus = 3 -- Only one statusline

-- File handling
vim.opt.backup = false -- Don't Create backup files
vim.opt.writebackup = false -- Don't Create backup files
vim.opt.swapfile = true -- Create swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 250 -- Faster completion
vim.opt.timeoutlen = 300 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save

-- Behavior settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.selection = "inclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Diagnostic settings
vim.diagnostic.config({
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		scope = "line",
		source = "if_many",
		border = "single",
	},
	virtual_text = {
		source = "if_many",
		spacing = 2,
	},
})

-- Override setqflist to always add to history instead of replacing
-- Vim maintains its own limit (10 lists by default)
local original_setqflist = vim.fn.setqflist
---@diagnostic disable-next-line: duplicate-set-field
vim.fn.setqflist = function(list, action, what)
	-- Convert 'r' (replace) to ' ' (add new) to maintain history
	-- When vim's internal limit is reached, it automatically drops the oldest
	-- EXCEPT: when updating properties of current list (empty list with 'what' parameter)
	if action == "r" then
		-- If it's just updating properties (empty list + what), allow the replace
		if not (#list == 0 and what) then
			action = " "
		end
	end

	-- Call original function
	if what then
		return original_setqflist(list, action, what)
	else
		return original_setqflist(list, action)
	end
end

-- Custom quickfix formatting function
function _G.qftf(info)
	local items
	local ret = {}

	if info.quickfix == 1 then
		items = vim.fn.getqflist({ id = info.id, items = 0 }).items
	else
		items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
	end

	local limit = 50
	local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
	local validFmt = "%s │%5d:%-3d│ %s"

	for i = info.start_idx, info.end_idx do
		local e = items[i]
		local fname = ""
		local str

		-- Handle both valid and invalid entries with formatting
		-- Invalid entries (e.valid == 0) are often entries without a file
		if e.bufnr > 0 then
			fname = vim.fn.bufname(e.bufnr)
		end

		if fname == "" or fname == nil then
			-- Use placeholder for entries without a file (built-in vim keymaps, etc.)
			fname = "[vim]"
		else
			-- Just get the basename (paths should already be absolute from keymaps_qf.lua)
			fname = vim.fn.fnamemodify(fname, ":t")
		end

		-- Truncate if still too long
		if #fname <= limit then
			fname = fnameFmt1:format(fname)
		else
			fname = fnameFmt2:format(fname:sub(1 - limit))
		end

		local lnum = e.lnum > 99999 and -1 or e.lnum
		local col = e.col > 999 and -1 or e.col
		str = validFmt:format(fname, lnum, col, e.text)

		table.insert(ret, str)
	end
	return ret
end

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

-- Override ui select with custom implementation
vim.ui.select = require("utils.selection-window").select

-- Cfilter package for quickfix filtering
vim.cmd("packadd cfilter")

-- Keymaps
require("keymaps")

-- Statusline
require("statusline")

-- Install plugin manager
require("lazy-install")

-- Load plugins
require("plugins")

-- Load autocommands
require("autocommands")

vim.lsp.enable({ "lua_ls" })
