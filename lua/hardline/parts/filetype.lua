local M = {}

function M.get_filetype()
  return vim.bo.filetype
end

function M.get_item()
  return table.concat({
    [[%{luaeval('require("hardline.parts.filetype").get_filetype()')}]],
  })
end

return M
