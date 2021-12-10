local diagnostic, fn, lsp = vim.diagnostic, vim.fn, vim.lsp
local fmt = string.format

local function get_diagnostic(prefix, severity)
  local count
  if fn.has('nvim-0.6') == 0 then
    count = lsp.diagnostic.get_count(0, severity)
  else
    local severities = {
      ['Warning'] = diagnostic.severity.WARNING,
      ['Error'] = diagnostic.severity.ERROR,
    }
    count = #diagnostic.get(0, {severity=severities[severity]})
  end
  if count < 1 then
    return ''
  end
  return fmt('%s:%d', prefix, count)
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
