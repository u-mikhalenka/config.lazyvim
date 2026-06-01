return {
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff working tree" },
      { "<leader>gD", "<cmd>DiffviewOpen HEAD~1..HEAD<cr>", desc = "Git diff last commit" },
      { "<leader>gm", "<cmd>DiffviewOpen master<cr>", desc = "Git diff against master" },
      { "<leader>gM", "<cmd>DiffviewOpen main<cr>", desc = "Git diff against main" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Git file history" },
      { "<leader>gR", "<cmd>DiffviewFileHistory<cr>", desc = "Git repo history" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
      {
        "<F7>",
        function()
          vim.cmd.normal({ "]c", bang = true })
        end,
        desc = "Diffview next change",
      },
      {
        "<F19>",
        function()
          vim.cmd.normal({ "[c", bang = true })
        end,
        desc = "Diffview previous change",
      },
    },
  },

  {
    "neogitorg/neogit",
    opts = {},
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Open Neogit UI",
      },
    },
  },
  { "nvim-lua/plenary.nvim" },
}
--
-- vim.opt.diffopt:append({
--     "algorithm:histogram",
--     "indent-heuristic",
--     "linematch:60",
-- })
