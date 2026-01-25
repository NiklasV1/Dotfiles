local function editorMode()
	local mode = vim.fn.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK", -- Ctrl-V
		c = "COMMAND",
		s = "SELECT",
		S = "S-LINE",
		["\19"] = "S-BLOCK", -- Ctrl-S
		R = "REPLACE",
		r = "REPLACE",
		["!"] = "SHELL",
		t = "TERMINAL",
	}
	return modes[mode] or mode:upper()
end

local function gitBranch()
	local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	if string.len(branch) > 0 then
		return branch
	else
		return ":"
	end
end

_G.sl_gitBranch = gitBranch
_G.sl_editorMode = editorMode

local function statusline()
	return table.concat({
		"%#ModeColor#",
		" %{v:lua.sl_editorMode()} ",
		"%#StatusLine#",
		" %{v:lua.sl_gitBranch()} | ",
		"%t",
	})
end

vim.api.nvim_set_hl(0, "ModeColor", { fg = "#FFFFFF", bg = "#000000" })

vim.opt.statusline = statusline()
