local cmd, fn, vim = vim.cmd, vim.fn, vim
local M = {}

function M.get_line()
  return string.format('%03d/%03d', fn.line('.'), fn.line('$'))
end

function M.get_column()
  return string.format('%03d/%03d', fn.col('.'), fn.col('$') - 1)
end

function M.get_percent()
  return '%03p%%'
end

function M.get_component()
  return table.concat({
    [[%{luaeval('require("hardline.line").get_line()')}]], ':',
    [[%{luaeval('require("hardline.line").get_column()')}]], ' ',
    M.get_percent(),
  })
end

return M
