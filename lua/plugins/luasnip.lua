return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      local ls = require("luasnip")

      for _, filetype in ipairs({
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "html",
        "htmlangular",
      }) do
        ls.filetype_extend(filetype, { "angular" })
      end

      return opts
    end,
  },
}
