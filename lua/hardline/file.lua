local fn, vim = vim.fn, vim
local M = {}

function M.get_mode()
  return ' %h%r'
end

function M.get_name()
  return fn.expand('%:~:.')
end

function M.get_component()
  return table.concat({
    [[%{luaeval('require("hardline.file").get_name()')}]],
    M.get_mode(),
  })
end

return M
