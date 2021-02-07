-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local fn, cmd, vim = vim.fn, vim.cmd, vim
local g, o, wo = vim.g, vim.o, vim.wo
local common = require('hardline.common')
local bufferline = require('hardline.bufferline')
local M = {}
local cache = {}

-------------------- OPTIONS -------------------------------
M.options = {
  bufferline = false,
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
  local aggregated, pivot, stop = {}, 1
  while pivot <= #sections do
    if type(sections[pivot]) == 'table' then
      local items = {}
      for j = pivot, #sections + 1 do
        stop = j == #sections + 1 or sections[j].class ~= sections[pivot].class
        if stop then
          table.insert(aggregated, {
            class = sections[pivot].class,
            item = string.format(' %s ', table.concat(items, ' ')),
          })
          pivot = j
          break
        end
        table.insert(items, sections[j].item)
      end
    else
      table.insert(aggregated, sections[pivot])
      pivot = pivot + 1
    end
  end
  return aggregated
end

local function remove_empty_sections(sections)
  local filter = function(s)
    if type(s) == 'table' then return s.item ~= '' else return s ~= '' end
  end
  return vim.tbl_filter(filter, sections)
end

local function reload_sections(sections)
  local function map(section)
    if type(section) == 'string' then
      return section
    elseif type(section) == 'function' then
      return section()
    elseif type(section) == 'table' then
      return {
        class = section.class or 'none',
        item = map(section.item),
      }
    end
    common.echo('WarningMsg', 'Invalid section.')
    return ''
  end
  return vim.tbl_map(map, sections)
end

local function remove_hidden_sections(sections)
  local filter = function(s) return not s.hide or s.hide <= fn.winwidth(0) end
  return vim.tbl_filter(filter, sections)
end

-------------------- SECTION HIGHLIGHTING ------------------
local function get_section_state(section)
  if section.class == 'mode' and common.is_active() then
    local mode = common.modes[fn.mode()] or common.modes['?']
    return mode.state
  end
  if section.class == 'bufferline' then
    if section.separator then return 'separator' end
    local state = section.current and 'current' or 'background'
    if section.modified then state = string.format('%s_modified', state) end
    return state
  end
  return common.is_active() and 'active' or 'inactive'
end

local function color_section(section)
  if type(section) ~= 'table' then return section end
  if section.class == 'none' then return section.item end
  local state = get_section_state(section)
  local hlgroup = string.format('Hardline_%s_%s', section.class, state)
  if fn.hlexists(hlgroup) == 0 then return section.item end
  return string.format('%%#%s#%s%%*', hlgroup, section.item)
end

-------------------- STATUSLINE ----------------------------
function M.update_statusline()
  local sections = cache.previous
  if common.is_active() or not sections then
    sections = M.options.sections
    sections = remove_hidden_sections(sections)
    sections = reload_sections(sections)
    sections = remove_empty_sections(sections)
    sections = aggregate_sections(sections)
    cache.previous, cache.current = cache.current, sections
  end
  return table.concat(vim.tbl_map(color_section, sections))
end

-------------------- BUFFERLINE ----------------------------
function M.update_bufferline()
  local sections = {}
  local buffers = bufferline.get_buffers()
  local separator = '|'
  for i, buffer in ipairs(buffers) do
    table.insert(sections, bufferline.to_section(buffer))
    if i < #buffers then table.insert(sections, separator) end
  end
  return table.concat(vim.tbl_map(color_section, sections))
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
      local hlgroup = string.format('Hardline_%s_%s', class, state)
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, string.format('%s=%s', k, v))
      end
      a = table.concat(a, ' ')
      cmd(string.format('autocmd VimEnter,ColorScheme * hi %s %s', hlgroup, a))
    end
  end
end

local function set_statusline()
  o.showmode = false
  o.statusline = [[%!luaeval('require("hardline").update_statusline()')]]
  wo.statusline = o.statusline
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
  if M.options.bufferline then set_bufferline() end
end

------------------------------------------------------------
return M
