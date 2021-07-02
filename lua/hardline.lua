-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local fn, cmd, vim = vim.fn, vim.cmd, vim
local g, o, wo = vim.g, vim.o, vim.wo
local fmt = string.format
local common = require('hardline.common')
local bufferline = require('hardline.bufferline')
local custom_colors = require('theme.custom_colors')
local M = {}

-------------------- OPTIONS -------------------------------
M.options = {
  bufferline = false,
  bufferline_settings = {
      exclude_terminal = false,
      show_index = false,
  },
  theme = 'default',
	-- custom_theme table
	custom_theme = {
		black = {gui = "#32302f", cterm = "236", cterm16 = "0"},
  	blue = { gui = "#83a598", cterm = "109", cterm16 = "12"},
  	cyan = {gui = "#8ec07c", cterm = "108", cterm16 = "14"},
  	green = {gui = "#b8bb26", cterm = "142", cterm16 = "10"},
  	grey_comment = {gui = "#928374", cterm = "244", cterm16 = "8"},
  	grey_cursor = {gui = "#665c54", cterm = "241", cterm16 = "8"},
  	grey_menu = {gui = "#7c6f64", cterm = "243", cterm16 = "8"},
  	purple = {gui = "#d3869b", cterm = "175", cterm16 = "13"},
  	red = {gui = "#fb4934", cterm = "167", cterm16 = "9"},
  	white = {gui = "#f2e5bc", cterm = "228", cterm16 = "15"},
  	yellow = {gui = "#fabd2f", cterm = "214", cterm16 = "11"},
	},
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

-------------------- SECTION CACHE -------------------------
local cache = {}

local function refresh_cache()
  for winid, _ in pairs(cache) do
    if fn.win_id2win(winid) == 0 then
      cache[winid] = nil
    end
  end
end

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
local function get_section_state(section)
  if section.class == 'mode' then
    if common.is_active() then
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
  return common.is_active() and 'active' or 'inactive'
end

local function highlight_section(section)
  if type(section) ~= 'table' then
    return section
  end
  if section.class == 'none' then
    return section.item
  end
  local state = get_section_state(section)
  local hlgroup = fmt('Hardline_%s_%s', section.class, state)
  if fn.hlexists(hlgroup) == 0 then
    return section.item
  end
  return fmt('%%#%s#%s%%*', hlgroup, section.item)
end

local function highlight_sections(sections)
  return vim.tbl_map(highlight_section, sections)
end

-------------------- STATUSLINE ----------------------------
function M.update_statusline()
  local sections = cache[g.statusline_winid]
  if common.is_active() or not sections then
    sections = M.options.sections
    sections = remove_hidden_sections(sections)
    sections = load_sections(sections)
    sections = remove_empty_sections(sections)
    sections = aggregate_sections(sections)
    cache[g.statusline_winid] = sections
    refresh_cache()
  end
  return table.concat(highlight_sections(sections))
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

local function set_custom_theme()
	if M.options.theme ~= nil then
		return
	elseif type(M.options.custom_theme) ~= 'table' then
		return
	end
	return custom_colors.set(M.options.custom_theme)
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
	set_custom_theme()
  set_hlgroups()
  set_statusline()
  if M.options.bufferline then
    set_bufferline()
  end
end

------------------------------------------------------------
return M
