local M = {}

function M.get_name()
  return vim.fn.expand('%:~:.')
end

function M.get_mode()
  return ' %h%r'
end

function M.get_item()
  return table.concat({
    '%<',
    [[%{luaeval('require("hardline.parts.filename").get_name()')}]],
    M.get_mode(),
  })
end

return M
