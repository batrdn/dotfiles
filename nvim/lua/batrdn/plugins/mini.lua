return {
    {
        'echasnovski/mini.surround',
        recommended = true,
        opts = {
            mappings = {
                add = 'sa',
                delete = 'sd',
                find = 'sf',
                find_left = 'sF',
                highlight = 'sh',
                replace = 'sr',
                update_n_lines = 'sn',
            },
        },
    },
    {
        'echasnovski/mini.pairs',
        event = 'VeryLazy',
        mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

            [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
            [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
            ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        },
        opts = {
            modes = { insert = true, command = true, terminal = false },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            skip_ts = { 'string' },
            skip_unbalanced = true,
            markdown = true,
        },
    },
    {
        'echasnovski/mini.icons',
        lazy = true,
        opts = {
            file = {
                ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
                ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
            },
            filetype = {
                dotenv = { glyph = '', hl = 'MiniIconsYellow' },
            },
        },
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },
}