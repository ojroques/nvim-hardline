local common = require('hardline.common')

local function get_dots(current, max)
  current = string.len(tostring(current))
  max = string.len(tostring(max))
  return string.rep('·', max - current)
end

local function get_line()
  local nb_lines = vim.fn.line('$')
  local line = vim.fn.line('.')
  local dots = get_dots(line, nb_lines)
  return string.format('%s%d/%d', dots, line, nb_lines)
end

local function get_column()
  local nb_columns = vim.fn.col('$')
  local column = vim.fn.col('.')
  local max_dots = get_dots(nb_columns, 999)
  local dots = get_dots(column, 999)
  return string.format('|%s%d/%s%d', dots, column, max_dots, nb_columns)
end

local function get_percent()
  local nb_lines = vim.fn.line('$')
  local line = vim.fn.line('.')
  local percent = math.floor(line * 100 / nb_lines)
  local dots = get_dots(percent, 100)
  return string.format('|%s%d%%%%', dots, percent)
end

local function get_item()
  return table.concat({' ', get_line(), get_column(), get_percent(), ' '})
end

return {
  get_item = get_item,
}
