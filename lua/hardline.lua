-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local fn, cmd, vim = vim.fn, vim.cmd, vim
local o, wo = vim.o, vim.wo
local fmt = string.format
local common = require('hardline.common')
local bufferline = require('hardline.bufferline')
local M = {}
local cache = {}

-------------------- OPTIONS -------------------------------
M.options = {
  bufferline = false,
  bufferline_settings = {
      exclude_terminal = false,
      show_index = false,
  },
  theme = 'default',
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 80},
    '%<',
    {class = 'med', item = require('hardline.parts.filename').get_item},
    {class = 'med', item = '%='},
    {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 80},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 80},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
}

-------------------- SECTION MANAGEMENT --------------------
local function aggregate_sections(sections)
  local aggregated, piv = {}, 1
  while piv <= #sections do
    if type(sections[piv]) == 'table' then
      local items = {}
      for j = piv, #sections + 1 do
        if j == #sections + 1 or sections[j].class ~= sections[piv].class then
          table.insert(aggregated, {
            class = sections[piv].class,
            item = fmt(' %s ', table.concat(items, ' ')),
          })
          piv = j
          break
        end
        table.insert(items, sections[j].item)
      end
    else
      table.insert(aggregated, sections[piv])
      piv = piv + 1
    end
  end
  return aggregated
end

local function remove_empty_sections(sections)
  local filter = function(section)
    if type(section) == 'table' then
      return section.item ~= ''
    end
    return section ~= ''
  end
  return vim.tbl_filter(filter, sections)
end

local function load_section(section)
  if type(section) == 'string' then
    return section
  end
  if type(section) == 'function' then
    return section()
  end
  if type(section) == 'table' then
    return {
      class = section.class or 'none',
      item = load_section(section.item),
    }
  end
  common.echo('WarningMsg', 'Invalid section.')
  return ''
end

local function load_sections(sections)
  return vim.tbl_map(load_section, sections)
end

local function remove_hidden_sections(sections)
  local filter = function(s)
    return not s.hide or s.hide <= fn.winwidth(0)
  end
  return vim.tbl_filter(filter, sections)
end

-------------------- SECTION HIGHLIGHTING ------------------
local function get_section_state(section, active)
  if section.class == 'mode' then
    if active then
      local mode = common.modes[fn.mode()] or common.modes['?']
      return mode.state
    end
  end
  if section.class == 'bufferline' then
    if section.separator then
      return 'separator'
    end
    local state = section.current and 'current' or 'background'
    if section.modified then
      state = fmt('%s_modified', state)
    end
    return state
  end
  return active and 'active' or 'inactive'
end

local function highlight_sections(sections, active)
  local highlight_section = function(section)
    if type(section) ~= 'table' then
      return section
    end
    if section.class == 'none' then
      return section.item
    end
    local state = get_section_state(section, active)
    local hlgroup = fmt('Hardline_%s_%s', section.class, state)
    if fn.hlexists(hlgroup) == 0 then
      return section.item
    end
    return fmt('%%#%s#%s%%*', hlgroup, section.item)
  end
  return vim.tbl_map(highlight_section, sections)
end

-------------------- STATUSLINE ----------------------------
function M.update_statusline(active)
  sections = M.options.sections
  sections = remove_hidden_sections(sections)
  sections = load_sections(sections)
  sections = remove_empty_sections(sections)
  sections = aggregate_sections(sections)
  return table.concat(highlight_sections(sections, active))
end

-------------------- BUFFERLINE ----------------------------
function M.update_bufferline()
  local sections = {}
  local settings = M.options.bufferline_settings
  local buffers = bufferline.get_buffers(settings)
  local separator = '|'
  for i, buffer in ipairs(buffers) do
    table.insert(sections, bufferline.to_section(buffer, i, settings))
    if i < #buffers then
      table.insert(sections, separator)
    end
  end
  return table.concat(highlight_sections(sections))
end

-------------------- SETUP -----------------------------
local function set_theme()
  if type(M.options.theme) ~= 'string' then
    return
  end
  local theme = fmt('hardline.themes.%s', M.options.theme)
  M.options.theme = require(theme)
end

local function set_hlgroups()
  for class, attr in pairs(M.options.theme) do
    for state, args in pairs(attr) do
      local hlgroup = fmt('Hardline_%s_%s', class, state)
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, fmt('%s=%s', k, v))
      end
      a = table.concat(a, ' ')
      cmd(fmt('autocmd VimEnter,ColorScheme * hi %s %s', hlgroup, a))
    end
  end
end

local function set_statusline()
  o.showmode = false
  o.statusline = [[%!luaeval('require("hardline").update_statusline(true)')]]
end

local function set_bufferline()
  o.showtabline = 2
  o.tabline = [[%!luaeval('require("hardline").update_bufferline()')]]
end

function M.setup(user_options)
  M.options = vim.tbl_extend('force', M.options, user_options)
  set_theme()
  set_hlgroups()
  set_statusline()
  if M.options.bufferline then
    set_bufferline()
  end
end

------------------------------------------------------------
return M
