local function clients_lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) == nil then
    return ""
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return "\u{f085} " .. table.concat(c, "|")
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_x = { "diagnostics", clients_lsp, "encoding", "fileformat", "filetype", "branch" }
    end,
  },
}
