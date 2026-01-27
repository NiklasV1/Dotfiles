local function execute()
	local currentWord = vim.fn.expand("<cWORD>")

	local issueNumber = currentWord:match("Issue%-(%d+)")
	if issueNumber then
		vim.ui.open(("https://github.com/snapADDY/issue-tracking/issues/%s"):format(issueNumber))
		return
	end
end

vim.keymap.set("n", "<leader>gx", execute, { desc = "[G]o E[x]ecute" })
