local M = {}

function M.get_line()
  return string.format('%03d/%03d', vim.fn.line('.'), vim.fn.line('$'))
end

function M.get_column()
  return string.format('%03d/%03d', vim.fn.col('.'), vim.fn.col('$') - 1)
end

function M.get_percent()
  return ' %03p%%'
end

function M.get_item()
  return table.concat({
    [[%{luaeval('require("hardline.parts.line").get_line()')}]], ':',
    [[%{luaeval('require("hardline.parts.line").get_column()')}]],
    M.get_percent(),
  })
end

return M
