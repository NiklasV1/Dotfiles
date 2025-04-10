-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set true term colors
vim.o.termguicolors = true

-- [[ Setting Options ]]
require("options")

-- [[ Keymaps ]]
require("keymaps")

-- Custom keymaps
require("extra.plugins.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-install")

-- [[ Configure and install plugins ]]
require("lazy-plugins")
