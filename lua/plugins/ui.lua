local function resume_picker(command, opts)
  local resume = require("snacks.picker.resume")

  if resume.state[command] then
    Snacks.picker.resume(command)
  else
    LazyVim.pick(command, opts)()
  end
end

return {
  { "folke/noice.nvim", enabled = false },

  -- customize bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ["*"] = {
          keys = {

            {
              "gr",
              function()
                Snacks.picker.lsp_references({
                  unique_lines = true,
                  focus = "list",
                  transform = function(item, ctx)
                    ctx.meta.seen = ctx.meta.seen or {}

                    local id = table.concat({
                      item.file or "",
                      item.pos and item.pos[1] or 0,
                      item.pos and item.pos[2] or 0,
                      item.end_pos and item.end_pos[1] or 0,
                      item.end_pos and item.end_pos[2] or 0,
                    }, ":")

                    if ctx.meta.seen[id] then
                      return false
                    end
                    ctx.meta.seen[id] = true
                    return item
                  end,
                })
              end,
              desc = "References",
              nowait = true,
            },
          },
        },
      },
    },
  },

  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "rmagatti/auto-session",
    enabled = true,
    lazy = false,
    keys = {
      { "<leader>qs", "<cmd>AutoSession search<CR>", desc = "Select session" },
      { "<leader>qS", "<cmd>AutoSession save<CR>", desc = "Save session" },
      { "<leader>qA", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    },
    opts = {
      auto_restore = true,
      git_use_branch_name = true,
      purge_after_minutes = 14400,
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader><space>",
        function()
          resume_picker("files")
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>/",
        function()
          resume_picker("grep")
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>ff",
        function()
          resume_picker("files")
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>fF",
        function()
          resume_picker("files", { root = false })
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>sg",
        function()
          resume_picker("grep")
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>sG",
        function()
          resume_picker("grep", { root = false })
        end,
        desc = "Grep (cwd)",
      },
    },
    opts = {
      dashboard = { enabled = false },
      picker = {
        layout = {
          preset = "vertical",
        },
        sources = {
          explorer = {
            actions = {
              explorer_add = function(picker)
                local ExplorerActions = require("snacks.explorer.actions")
                local Tree = require("snacks.explorer.tree")
                local uv = vim.uv or vim.loop

                Snacks.input({
                  prompt = 'Add a new file or directory (directories end with a "/")',
                }, function(value)
                  if not value or value:find("^%s*$") then
                    return
                  end

                  local dir = picker:dir()
                  local paths = vim.tbl_map(function(path)
                    return {
                      path = svim.fs.normalize(path),
                      is_file = path:sub(-1) ~= "/",
                    }
                  end, vim.split(vim.fn.expand(dir .. "/" .. value), "\n", { trimempty = true }))

                  for _, item in ipairs(paths) do
                    if item.is_file and uv.fs_stat(item.path) then
                      Snacks.notify.warn("File already exists:\n- `" .. item.path .. "`")
                      return
                    end
                  end

                  for _, item in ipairs(paths) do
                    local target_dir = item.is_file and vim.fs.dirname(item.path) or item.path
                    vim.fn.mkdir(target_dir, "p")
                    if item.is_file then
                      io.open(item.path, "w"):close()
                    end
                  end

                  Tree:refresh(dir)
                  ExplorerActions.update(picker, { target = paths[1].path, refresh = true })
                end)
              end,
            },
          },
        },
      },
    },
  },
}
