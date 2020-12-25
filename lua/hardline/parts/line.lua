local fn = vim.fn

local function get_line()
  local nb_lines = fn.line('$')
  local line = fn.line('.')
  return string.format('%3d/%3d', line, nb_lines)
end

local function get_column()
  local nb_columns = fn.col('$') - 1
  local column = fn.col('.')
  return string.format('%2d/%2d', column, nb_columns)
end

local function get_percent()
  local nb_lines = fn.line('$')
  local line = fn.line('.')
  local percent = math.floor(line * 100 / nb_lines)
  return string.format('%3d%%%%', percent)
end

local function get_item()
  return table.concat({get_line(), get_column(), get_percent()}, ' ')
end

return {
  get_item = get_item,
}
