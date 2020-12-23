local function get_name()
  return vim.fn.expand('%:~:.')
end

local function get_mode()
  return ' %h%r'
end

return {
  item = table.concat({'%<', get_name(), get_mode()}),
}
