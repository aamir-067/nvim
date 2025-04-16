vim.g.mapleader = " "

-- I installed neo-tree inseated of default file tree.
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fw", function()
	builtin.grep_string({ search = vim.fn.input("Word Finder > ") })
end)

vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- harpoon mappings
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>r", mark.rm_file)
vim.keymap.set("n", "<leader>ca",mark.clear_all)

vim.keymap.set("n", "1", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "2", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "3", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "4", function()
	ui.nav_file(4)
end)
vim.keymap.set("n", "5", function()
	ui.nav_file(5)
end)
vim.keymap.set("n", "6", function()
	ui.nav_file(6)
end)
vim.keymap.set("n", "7", function()
	ui.nav_file(7)
end)
vim.keymap.set("n", "8", function()
	ui.nav_file(8)
end)
vim.keymap.set("n", "9", function()
	ui.nav_file(9)
end)
vim.keymap.set("n", "10", function()
	ui.nav_file(10)
end)

-- undo tree
vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle)

-- git fugitive mappings
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- noice mappings
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "clear noice messages" })

-- neo tree command.
vim.api.nvim_set_keymap(
  'n', -- Mode: 'n' for normal mode
  '<leader>pv', -- Shortcut: change '<leader>n' to any key combination you prefer
  ':Neotree source=filesystem reveal=true position=right<CR>', -- Command
  { noremap = true, silent = true } -- Options
)

-- to create a new file
vim.api.nvim_set_keymap(
  'n', -- Mode: 'n' for normal mode
  '<leader>nf', -- Shortcut: change '<leader>n' to any key combination you prefer
  ':edit ', -- Command
  { noremap = true, silent = true } -- Options
)




 -- scroll Shortcuts  todo: fix this
vim.api.nvim_set_keymap('n', '-', '<C-u>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '=', '<C-d>', { noremap = true, silent = true })


-- files adding shortcuts.
vim.keymap.set('n', '<leader>E', ':Explore<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>F', function()
  vim.ui.input({ prompt = "Create new directory: " }, function(input)
    if input then
      vim.fn.mkdir(input, "p")
      print("Folder created: " .. input)
    end
  end)
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>f', function()
  vim.ui.input({ prompt = "Create new file: " }, function(input)
    if input then
      local file = io.open(input, "w")
      if file then
        file:close()
        vim.cmd("edit " .. input)
        print("File created and opened: " .. input)
      else
        print("Failed to create file: " .. input)
      end
    end
  end)
end, { noremap = true, silent = true })



