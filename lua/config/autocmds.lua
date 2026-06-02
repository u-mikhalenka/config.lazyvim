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

local title_group = vim.api.nvim_create_augroup("kolahan_terminal_title", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  group = title_group,
  callback = update_terminal_title,
})

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

-- Force-restart every active LSP client and reattach LSPs for listed file buffers.
local function restart_all_lsp()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    vim.notify("No active LSP clients", vim.log.levels.INFO)
    return
  end

  for _, client in ipairs(clients) do
    client:stop(true)
  end

  local attempts = 0
  local function restart_when_stopped()
    attempts = attempts + 1

    if #vim.lsp.get_clients() > 0 and attempts < 10 then
      vim.defer_fn(restart_when_stopped, 100)
      return
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if
        vim.api.nvim_buf_is_valid(buf)
        and vim.api.nvim_buf_is_loaded(buf)
        and vim.bo[buf].buflisted
        and vim.bo[buf].buftype == ""
        and vim.bo[buf].filetype ~= ""
      then
        vim.api.nvim_exec_autocmds("FileType", {
          buffer = buf,
          modeline = false,
        })
      end
    end

    vim.notify("Restarted all LSP clients", vim.log.levels.INFO)
  end

  restart_when_stopped()
end

vim.api.nvim_create_user_command("LspRestartAll", restart_all_lsp, {
  desc = "Restart all LSP clients for all listed buffers",
})

-- smarter detection of filetype for angular templates
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.html" },
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if path == "" then
      return
    end

    local root = vim.fs.find({ "angular.json", "nx.json" }, {
      path = vim.fs.dirname(path),
      upward = true,
      stop = vim.uv.os_homedir(),
    })[1]

    if root then
      vim.bo[args.buf].filetype = "htmlangular"
    end
  end,
})
