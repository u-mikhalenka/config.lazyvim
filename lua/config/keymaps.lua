-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local last_terminal_count = 1

local function toggle_terminal_count(count)
  last_terminal_count = count
  Snacks.terminal(nil, { count = count })
end

vim.keymap.set({ "n", "t" }, "<c-/>", function()
  if vim.v.count > 0 then
    last_terminal_count = vim.v.count
  elseif type(vim.b.snacks_terminal) == "table" and vim.b.snacks_terminal.id then
    last_terminal_count = vim.b.snacks_terminal.id
  end

  Snacks.terminal(nil, { count = last_terminal_count })
end, { desc = "Toggle Terminal" })

for i = 1, 5 do
  vim.keymap.set({ "n", "t" }, "<A-" .. i .. ">", function()
    toggle_terminal_count(i)
  end, { desc = "Toggle Terminal " .. i })
end

local yank = require("utils.yank")
vim.keymap.set("n", "<leader>ya", function()
  yank.yank_path(yank.get_buffer_absolute(), "absolute")
end, { desc = "[Y]ank [A]bsolute path to clipboard" })

vim.keymap.set("n", "<leader>yr", function()
  yank.yank_path(yank.get_buffer_cwd_relative(), "relative")
end, { desc = "[Y]ank [R]elative path to clipboard" })

vim.keymap.set("v", "<leader>ya", function()
  yank.yank_visual_with_path(yank.get_buffer_absolute(), "absolute")
end, { desc = "[Y]ank selection with [A]bsolute path" })

vim.keymap.set("v", "<leader>yr", function()
  yank.yank_visual_with_path(yank.get_buffer_cwd_relative(), "relative")
end, { desc = "[Y]ank selection with [R]elative path" })

vim.keymap.set("n", "<leader>yy", '"+y', { desc = "[Y]ank to s[y]stem clipboard" })
vim.keymap.set("v", "<leader>yy", '"+y', { desc = "[Y]ank to s[y]stem clipboard" })
vim.keymap.set("n", "<leader>YY", '"+Y', { desc = "[Y]ank to s[y]stem clipboard" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete without yanking" })
