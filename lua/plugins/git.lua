return {
  {
    "sindrets/diffview.nvim",
    enabled = false,
    opts = {
      hooks = {
        diff_buf_win_enter = function(_, winid)
          vim.wo[winid].foldlevel = 99
        end,
      },
    },
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
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    keys = {

      { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Git diff working tree" },
      { "<leader>gD", "<cmd>CodeDiff HEAD~1..HEAD<cr>", desc = "Git diff last commit" },
      { "<leader>gm", "<cmd>CodeDiff master<cr>", desc = "Git diff against master" },
      { "<leader>gM", "<cmd>CodeDiff main<cr>", desc = "Git diff against main" },
    },
    opts = {
      diff = {
        ignore_trim_whitespace = true,
        compute_moves = true,
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
