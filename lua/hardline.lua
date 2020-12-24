-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local api, cmd, fn, vim = vim.api, vim.cmd, vim.fn, vim
local wo = vim.wo
local common = require('hardline.common')
local M = {}

-------------------- OPTIONS -------------------------------
M.options = {
  theme = 'one',
  events = {
    active = {
      'WinEnter',
    },
    inactive = {
      'WinLeave',
    },
  },
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item},
    {class = 'med', item = require('hardline.parts.filename').get_item},
    '%=',
    {class = 'high', item = require('hardline.parts.filetype').get_item},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
}

-------------------- STATUSLINE ----------------------------
local function color_item(class, mode, item)
  if not class or not mode then return item end
  local hlgroup = string.format('Hardline_%s_%s', class, mode)
  if fn.hlexists(hlgroup) == 0 then return item end
  return string.format('%%#%s#%s%%*', hlgroup, item)
end

local function update_section(section)
  if type(section) == 'function' then
    return section()
  elseif type(section) == 'string' then
    return section
  elseif type(section) == 'table' and type(section.item) == 'function' then
    local item = section.item()
    return color_item(section.class, item.mode, item.text)
  end
  common.echo('WarningMsg', 'Invalid section.')
  return ''
end

function M.update()
  return table.concat(vim.tbl_map(update_section, M.options.sections))
end

-------------------- SETUP -----------------------------
local function set_autocmds()
  cmd 'augroup hardline'
  cmd 'autocmd!'
  for mode, events in pairs(M.options.events) do
    for _, event in ipairs(events) do
      local raw_str = 'autocmd %s * lua require("hardline").set_statusline()'
      cmd(string.format(raw_str, event))
    end
  end
  cmd 'augroup END'
end

local function set_hlgroups()
  for class, attr in pairs(M.options.theme) do
    for mode, args in pairs(attr) do
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, string.format('%s=%s', k, v))
      end
      a = table.concat(a, ' ')
      cmd(string.format('hi Hardline_%s_%s %s', class, mode, a))
    end
  end
end

local function set_theme()
  if type(M.options.theme) == 'string' then
    local theme = require(string.format('hardline.themes.%s', M.options.theme))
    M.options.theme = theme
  end
end

function M.set_statusline()
  common.set_active('active')
  wo.statusline = [[%!luaeval('require("hardline").update()')]]
end

function M.setup(user_options)
  M.options = vim.tbl_extend('force', M.options, user_options)
  set_theme()
  set_hlgroups()
  set_autocmds()
  M.set_statusline()
end

------------------------------------------------------------
return M
