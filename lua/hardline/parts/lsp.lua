local diagnostic, fn, lsp = vim.diagnostic, vim.fn, vim.lsp
local fmt = string.format

local function get_diagnostic(prefix, severity)
  local count
  if fn.has('nvim-0.6') == 0 then
    count = lsp.diagnostic.get_count(0, severity)
  else
    local severities = {
      ['Warning'] = diagnostic.severity.WARN,
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

local function get_lsp_clients()
  local clients = vim.lsp.buf_get_clients()
  if next(clients) == nil then
    return "none"
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return table.concat(c, "|")
end

return {
  get_error = get_error,
  get_warning = get_warning,
  get_lsp_clients = get_lsp_clients,
}
