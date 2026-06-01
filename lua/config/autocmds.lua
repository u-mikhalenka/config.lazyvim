-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function update_terminal_title()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  if cwd == "" then
    cwd = vim.fn.getcwd()
  end

  vim.opt.titlestring = string.format("%s", cwd)
end

local function auto_restore_session()
  if vim.fn.argc() > 0 then
    return
  end

  pcall(function()
    require("persistence").load()
  end)
end

local title_group = vim.api.nvim_create_augroup("kolahan_terminal_title", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  group = title_group,
  callback = update_terminal_title,
})

vim.schedule(auto_restore_session)
update_terminal_title()

vim.api.nvim_create_autocmd({
  "FocusGained",
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
  "TermClose",
  "TermLeave",
}, {
  group = vim.api.nvim_create_augroup("kolahan_autoread", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("kolahan_file_changed", { clear = true }),
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO)
  end,
})
