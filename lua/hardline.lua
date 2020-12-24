-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local cmd, fn, vim = vim.cmd, vim.fn, vim
local o, wo = vim.wo, vim.o
local common = require('hardline.common')
local M = {}

-------------------- OPTIONS -------------------------------
M.options = {
  theme = 'one',
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item},
    {class = 'med', item = require('hardline.parts.filename').get_item},
    {class = 'med', item ='%='},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'high', item = require('hardline.parts.filetype').get_item},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
}

-------------------- STATUSLINE ----------------------------
local function get_state(class)
  if class == 'mode' and common.is_active() then
    local mode = common.modes[vim.fn.mode()]
    if not mode then return common.modes['?'].color end
    return mode.color
  end
  return common.is_active() and 'active' or 'inactive'
end

local function color_item(class, item)
  if not class then return item end
  local state = get_state(class)
  local hlgroup = string.format('Hardline_%s_%s', class, state)
  if fn.hlexists(hlgroup) == 0 then return item end
  return string.format('%%#%s#%s%%*', hlgroup, item)
end

local function update_section(section)
  if type(section) == 'function' then
    return section()
  elseif type(section) == 'string' then
    return section
  elseif type(section) == 'table' then
    return color_item(section.class, update_section(section.item))
  end
  common.echo('WarningMsg', 'Invalid section.')
  return ''
end

function M.update()
  return table.concat(vim.tbl_map(update_section, M.options.sections))
end

-------------------- SETUP -----------------------------
local function set_theme()
  if type(M.options.theme) ~= 'string' then return end
  local theme = string.format('hardline.themes.%s', M.options.theme)
  M.options.theme = require(theme)
end

local function set_hlgroups()
  for class, attr in pairs(M.options.theme) do
    for state, args in pairs(attr) do
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, string.format('%s=%s', k, v))
      end
      a = table.concat(a, ' ')
      cmd(string.format('hi Hardline_%s_%s %s', class, state, a))
    end
  end
end

local function set_statusline()
  o.statusline = [[%!luaeval('require("hardline").update()')]]
  wo.statusline = o.statusline
end

function M.setup(user_options)
  M.options = vim.tbl_extend('force', M.options, user_options)
  set_theme()
  set_hlgroups()
  set_statusline()
end

------------------------------------------------------------
return M
