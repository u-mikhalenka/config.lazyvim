return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "html",
        "css",
        "bash",
        "diff",
        "jsdoc",
        "markdown",
        "regex",
        "toml",
        "xml",
        "yaml",
      })
    end,
  },
}
