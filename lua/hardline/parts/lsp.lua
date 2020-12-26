local lsp = vim.lsp

local function get_diagnostic(prefix, severity)
  local count = lsp.diagnostic.get_count(0, severity)
  if count < 1 then return '' end
  return string.format('%s:%d', prefix, count)
end

local function get_error()
  return get_diagnostic('E', 'Error')
end

local function get_warning()
  return get_diagnostic('W', 'Warning')
end

return {
  get_error = get_error,
  get_warning = get_warning,
}
