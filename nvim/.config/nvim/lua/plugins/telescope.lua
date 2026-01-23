-- Keymaps
local keymaps = {
	refine = { ["<C-Space>"] = "to_fuzzy_refine" }, -- Refine search results
	buffers = { ["<C-d>"] = "delete_buffer" }, -- Delete buffer
}

-- Border characters
local borders = {
	default = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	alt = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
}

-- File paths behind file names
local function filenameFirst(_, path)
	local tail = require("telescope.utils").path_tail(path)
	return string.format("%s\t\t|\t\t%s\t\t", tail, path)
end

-- File path color
local function setupFilePathColoring()
	local telescopeAutoCommandGroup = vim.api.nvim_create_augroup("telescopeAutoCommandGroup", { clear = true })
	vim.api.nvim_create_autocmd("Filetype", {
		pattern = "TelescopeResults",
		group = telescopeAutoCommandGroup,
		callback = function(ctx)
			vim.api.nvim_buf_call(ctx.buf, function()
				vim.fn.clearmatches()
				vim.fn.matchadd("TelescopeFullFilePath", [[\t\t|\t\t\zs.*\ze\t\t]])
			end)
		end,
	})
	vim.api.nvim_set_hl(0, "TelescopeFullFilePath", { link = "Comment" })
end

-- Basic settings
local basicSettings = {
	border = true,
	borderchars = borders.default,
	mappings = {
		i = keymaps.refine,
		n = keymaps.refine,
	},
	layout_strategy = "vertical",
	layout_config = {
		vertical = {
			height = 0.9,
			width = 0.8,
			prompt_position = "bottom",
			preview_cutoff = 20,
			scroll_speed = 2,
		},
	},
	path_display = filenameFirst,
}

-- Picker settings
local pickerSettings = {
	buffers = {
		mappings = {
			i = keymaps.buffers,
			n = keymaps.buffers,
		},
		sort_mru = true,
		disable_coordinates = true,
	},
	live_grep = {
		disable_coordinates = true,
	},
	grep_string = {
		disable_coordinates = true,
	},
	quickfix = {
		fname_width = 98,
		path_display = "absolute",
	},
	lsp_document_symbols = {
		symbol_width = 50,
		symbol_type_width = 16,
	},
}

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- 10x fzf speedup | requires make
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- Icons for filetypes
	},
	config = function()
		-- Change color of file paths
		setupFilePathColoring()

		-- Setup telescope
		require("telescope").setup({
			defaults = basicSettings,
			pickers = pickerSettings,
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Load extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- Load keymaps
		require("keymaps.telescope").setup(require("telescope.builtin"), borders)
	end,
}
