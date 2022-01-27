local ok, gps = pcall(require, 'nvim-gps')
if not ok then gps = nil end

local function get_context()
  if not gps or not gps.is_available() then
    return ''
  end
  return gps.get_location()
end

local function get_item()
  return get_context()
end

return {
  get_item = get_item,
}
