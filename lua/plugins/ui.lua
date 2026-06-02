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
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
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
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            max_width = 220,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            border = true,
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.6, border = "top" },
          },
        },
      },
    },
  },
}
