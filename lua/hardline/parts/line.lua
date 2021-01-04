local fn = vim.fn

local function pad(c, m)
  local padch = '·'
  return string.rep(padch, string.len(tostring(m)) - string.len(tostring(c)))
end

local function get_line()
  local nbline = fn.line('$')
  local line = fn.line('.')
  return string.format('%s%d/%d', pad(line, nbline), line, nbline)
end

local function get_column()
  local nbcol = fn.col('$') - 1
  local col = fn.col('.')
  return string.format('%s%d/%s%d', pad(col, 100), col, pad(nbcol, 100), nbcol)
end

local function get_percent()
  local nb_lines = fn.line('$')
  local line = fn.line('.')
  local percent = math.floor(line * 100 / nb_lines)
  return string.format('%s%d%%%%', pad(percent, 100), percent)
end

local function get_item()
  return table.concat({get_line(), get_column(), get_percent()}, ' ')
end

return {
  get_item = get_item,
}
