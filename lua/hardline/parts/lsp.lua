local lsp, vim = vim.lsp, vim

local function get_diagnostic(prefix, severity)
  if vim.tbl_isempty(lsp.buf_get_clients(0)) then return '' end
  local count = lsp.diagnostic.get_count(0, severity)
  if count < 1 then return '' end
  return table.concat({' ', string.format('%s:%d', prefix, count), ' '})
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
