local common = require('hardline.common')

local function get_dots(current, max)
  current = string.len(tostring(current))
  max = string.len(tostring(max))
  return string.rep('·', max - current)
end

local function get_line()
  local nb_lines = vim.fn.line('$')
  local current_line = vim.fn.line('.')
  local dots = get_dots(current_line, nb_lines)
  return string.format(' %s%d/%d', dots, current_line, nb_lines)
end

local function get_column()
  local nb_columns = vim.fn.col('$')
  local current_column = vim.fn.col('.')
  local dots = get_dots(current_column, 999)
  local max_dots = get_dots(nb_columns, 999)
  return string.format('|%s%d/%s%d', dots, current_column, max_dots, nb_columns)
end

local function get_percent()
  local nb_lines = vim.fn.line('$')
  local current_line = vim.fn.line('.')
  local percent = math.floor(current_line * 100 / nb_lines)
  local dots = get_dots(percent, 100)
  return string.format('|%s%d%%%% ', dots, percent)
end

local function get_item()
  local mode = common.get_mode()
  return {
    text = table.concat({get_line(), get_column(), get_percent()}),
    mode = mode.color,
  }
end

return {
  get_item = get_item,
}
