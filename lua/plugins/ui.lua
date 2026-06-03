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
    opts = {
      dashboard = { enabled = false },
      picker = {
        layout = {
          preset = "vertical",
        },
      },
    },
  },
}
