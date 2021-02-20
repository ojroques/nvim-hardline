local cterm = require'hardline.colors.cterm'

function hex2rgb (hex)
    local hex = hex:gsub("#","")
    return {tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255}
end

local style_cache = {}
local function hex_to_style(hex)
    if style_cache[hex] then
        return style_cache[hex]
    end

    local rgb = hex2rgb(hex)
    return {
        gui = hex,
        cterm = cterm.rgb_to_cterm(rgb),
        cterm16 = cterm.rgb_to_cterm(rgb, true)
    }
end

local default = {
    black        = '#282C34',
    blue         = '#61AFEF',
    cyan         = '#56B6C2',
    green        = '#98C379',
    grey_comment = "#5C6370",
    grey_cursor  = "#2C323C",
    grey_menu    = "#3E4452",
    purple       = '#C678DD',
    red          = '#E06C75',
    white        = '#ABB2BF',
    yellow       = '#E5C07B',
}

local M = {}

function M.expand_palette(palette)
    local out = {}
    for k, v in pairs(default) do
        local style = palette[k] or v
        if type(style) == 'string' then
            style = hex_to_style(style)
        end
        out[k] = style
    end
    return out
end


function M.palette_to_theme(palette)
    local palette = M.expand_palette(palette) 
    local inactive = {
        guifg = palette.grey_comment.gui,
        guibg = palette.grey_cursor.gui,
        ctermfg = palette.grey_comment.cterm,
        ctermbg = palette.grey_cursor.cterm,
    }

    return {
        mode = {
            inactive = inactive,
            normal = {
                guifg = palette.black.gui,
                guibg = palette.green.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.green.cterm,
            },
            insert = {
                guifg = palette.black.gui,
                guibg = palette.blue.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.blue.cterm,
            },
            replace = {
                guifg = palette.black.gui,
                guibg = palette.cyan.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.cyan.cterm,
            },
            visual = {
                guifg = palette.black.gui,
                guibg = palette.purple.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.purple.cterm,
            },
            command = {
                guifg = palette.black.gui,
                guibg = palette.red.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.red.cterm,
            },
        },
        low = {
            active = {
                guifg = palette.white.gui,
                guibg = palette.grey_cursor.gui,
                ctermfg = palette.white.cterm,
                ctermbg = palette.grey_cursor.cterm,
            },
            inactive = inactive,
        },
        med = {
            active = {
                guifg = palette.yellow.gui,
                guibg = palette.grey_cursor.gui,
                ctermfg = palette.yellow.cterm,
                ctermbg = palette.grey_cursor.cterm,
            },
            inactive = inactive,
        },
        high = {
            active = {
                guifg = palette.white.gui,
                guibg = palette.grey_menu.gui,
                ctermfg = palette.white.cterm,
                ctermbg = palette.grey_menu.cterm,
            },
            inactive = inactive,
        },
        error = {
            active = {
                guifg = palette.black.gui,
                guibg = palette.red.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.red.cterm,
            },
            inactive = inactive,
        },
        warning = {
            active = {
                guifg = palette.black.gui,
                guibg = palette.yellow.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.yellow.cterm,
            },
            inactive = inactive,
        },
        bufferline = {
            separator = inactive,
            current = {
                guifg = palette.black.gui,
                guibg = palette.green.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.green.cterm,
            },
            current_modified = {
                guifg = palette.black.gui,
                guibg = palette.blue.gui,
                ctermfg = palette.black.cterm,
                ctermbg = palette.blue.cterm,
            },
            background = {
                guifg = palette.green.gui,
                guibg = palette.black.gui,
                ctermfg = palette.green.cterm,
                ctermbg = palette.black.cterm,
            },
            background_modified = {
                guifg = palette.blue.gui,
                guibg = palette.black.gui,
                ctermfg = palette.blue.cterm,
                ctermbg = palette.black.cterm,
            },
        },
    }
end


return M
