local fmt = string.format

local function get_diagnostic(prefix, severity)
  local count = #vim.diagnostic.get(0, {severity=severity})
  if count < 1 then
    return ''
  end
  return fmt('%s:%d', prefix, count)
end

local function get_error()
  return get_diagnostic('E', vim.diagnostic.severity.ERROR)
end

local function get_warning()
  return get_diagnostic('W', vim.diagnostic.severity.WARN)
end

return {
  get_error = get_error,
  get_warning = get_warning,
}
