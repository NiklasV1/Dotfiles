-- NOTE: Custom commands

-- Taskwarrior
vim.api.nvim_create_user_command("LTask", "!task list", { desc = "Show the task list." })
vim.api.nvim_create_user_command("GTask", "!task list | grep <f-args>", { nargs = 1, desc = "Grep the task list." })
