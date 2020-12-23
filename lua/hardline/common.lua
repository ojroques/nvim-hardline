local M = {}

function M.echo(hlgroup, msg)
  vim.cmd(string.format('echohl %s', hlgroup))
  vim.cmd(string.format('echo "[hardline] %s"', msg))
  vim.cmd('echohl None')
end

function M.set_active(active)
  vim.api.nvim_win_set_var(0, 'hardline_active', active)
end

function M.is_active()
  return vim.api.nvim_win_get_var(0, 'hardline_active')
end

return M
