local M = {}

M.theme = require('hardline.themes.default')

function M.echo(hlgroup, msg)
  vim.cmd(string.format('echohl %s', hlgroup))
  vim.cmd(string.format('echo "[hardline] %s"', msg))
  vim.cmd('echohl None')
end

function M.build_args(tbl_args)
  local args = {}
  for k, v in pairs(tbl_args) do
    table.insert(args, string.format('%s=%s', k, v))
  end
  return table.concat(args, ' ')
end

function M.set_active(active)
  vim.api.nvim_win_set_var(0, 'hardline_active', active)
end

function M.is_active()
  return vim.api.nvim_win_get_var(0, 'hardline_active')
end

return M
