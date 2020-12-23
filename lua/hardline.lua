-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local cmd, vim = vim.cmd, vim
local wo = vim.wo
local M = {}

-------------------- OPTIONS -------------------------------
M.events = {
  active = {
    'BufEnter',
    'BufReadPost',
    'BufWinEnter',
    'BufWritePost',
    'FileChangedShellPost',
    'FileType',
    'VimResized',
    'WinEnter',
  },
  inactive = {
    'WinLeave',
  },
}

M.sections = {
  {class = 'A', item = require('hardline.mode').get_item()}, ' ',
  {class = 'B', item = require('hardline.git').get_item()}, ' ',
  {class = 'C', item = require('hardline.filename').get_item()}, ' ',
  '%=',
  -- {class = 'error', item = require('hardline.lsp').get_error()}, ' ',
  -- {class = 'warning', item = require('hardline.lsp').get_warning()}, ' ',
  -- {class = 'warning', item = require('hardline.whitespace').get_item()}, ' ',
  -- {class = 'X', item = require('hardline.wordcount').get_item()}, ' ',
  {class = 'Y', item = require('hardline.filetype').get_item()}, ' ',
  {class = 'Z', item = require('hardline.line').get_item()},
}

M.colors = {
  active = {
    A = {ctermfg='170',guifg='#C678DD'},
  },
  inactive = {
    A = {ctermfg='170',guifg='#C678DD'},
  },
}

-------------------- HELPERS -------------------------------
local function echo(hlgroup, msg)
  cmd(string.format('echohl %s', hlgroup))
  cmd(string.format('echo "[hardline] %s"', msg))
  cmd('echohl None')
end

-------------------- STATUSLINE ----------------------------
local function color_item(item, class, active)
  local mode = active and 'Active' or 'Inactive'
  if not M.colors[string.lower(mode)][class] then return item end
  return string.format('%%#Hardline%s%s#%s%%##', mode, class, item)
end

local function reload_section(section, active)
  if type(section) == 'function' then
    return section()
  elseif type(section) == 'string' then
    return section
  elseif type(section) == 'table' then
    return color_item(section.item, section.class, active)
  end
  echo('WarningMsg', 'Invalid section.')
  return ''
end

function M.reload(active)
  local items = {}
  for _, section in ipairs(M.sections) do
    table.insert(items, reload_section(section, active))
  end
  wo.statusline = table.concat(items)
end

-------------------- SETUP -----------------------------
local function set_hlgroups()
  for _, mode in ipairs({'Active', 'Inactive'}) do
    local m = string.lower(mode)
    for class, args in pairs(M.colors[m]) do
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, string.format('%s=%s', k, v))
      end
      cmd(string.format('hi Hardline%s%s %s', mode, class, table.concat(a, ' ')))
    end
  end
end

local function set_autocmds()
  cmd 'augroup hardline'
  cmd 'autocmd!'
  for mode, events in pairs(M.events) do
    for _, event in ipairs(events) do
      local raw_str = 'autocmd %s * lua require("hardline").reload(%s)'
      cmd(string.format(raw_str, event, mode == 'active'))
    end
  end
  cmd 'augroup END'
end

function M.setup(user_opts)
  set_hlgroups()
  set_autocmds()
end

------------------------------------------------------------
return M
