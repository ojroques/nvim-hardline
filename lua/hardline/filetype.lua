local vim = vim
local bo = vim.bo
local M = {}

function M.get_filetype()
  return bo.filetype
end

function M.get_item()
  return table.concat({
    [[%{luaeval('require("hardline.filetype").get_filetype()')}]],
  })
end

return M
