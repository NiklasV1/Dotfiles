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
vim.cmd.colorscheme("retrobox") -- Colorscheme
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#ffffff", bg = "#303030" })
vim.api.nvim_set_hl(0, "TelescopePreviewLine", { fg = "#ffffff", bg = "#303030" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#404040" })
vim.cmd("set background=dark") -- Dark mode
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.g.have_nerd_font = true -- Enable nerd font
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.showmode = false -- Don't show mode in command line
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

-- Cfilter package for quickfix filtering
vim.cmd("packadd cfilter")

-- Keymaps
require("keymaps")

-- Install plugin manager
require("lazy-install")

-- Load plugins
require("plugins")
