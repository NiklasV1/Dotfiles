return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = { enabled = true },
			copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v22.14.0/bin/node",
		})
	end,
}
