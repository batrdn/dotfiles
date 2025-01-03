return {
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
        end,
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('aerial').setup({
                on_attach = function(bufnr)
                    vim.keymap.set('n', '(', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                    vim.keymap.set('n', ')', '<cmd>AerialNext<CR>', { buffer = bufnr })
                end,
                layout = {
                    default_direction = 'prefer_left',
                },
                filter_kind = {
                    'Class',
                    'Function',
                    'Interface',
                    'Module',
                    'Method',
                    'Struct',
                },
            })

            vim.keymap.set('n', '<leader>A', '<cmd>AerialToggle!<CR>')
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
    {
        'echasnovski/mini.icons',
        lazy = true,
        opts = {
            file = {
                ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
                ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
            },
            filetype = {
                dotenv = { glyph = '', hl = 'MiniIconsYellow' },
            },
        },
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'catppuccin',
                    icons_enabled = true,
                    component_separators = '|',
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        'diagnostics',
                        'filename',
                    },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { 'diff', 'branch' },
                    -- TODO: show git worktree
                    lualine_z = {},
                },
            })
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = function()
            return {
                indent = {
                    char = '│',
                    tab_char = '│',
                },
                scope = { show_start = false, show_end = false },
                exclude = {
                    filetypes = {
                        'help',
                        'alpha',
                        'dashboard',
                        'neo-tree',
                        'Trouble',
                        'trouble',
                        'lazy',
                        'mason',
                        'notify',
                        'toggleterm',
                        'lazyterm',
                    },
                },
            }
        end,
        main = 'ibl',
    },
    {
        'rcarriga/nvim-notify',
        dependencies = { 'folke/noice.nvim' },
        keys = {
            {
                '<leader>un',
                function()
                    require('notify').dismiss({ silent = true, pending = true })
                end,
                desc = 'Dismiss All Notifications',
            },
        },
        opts = {
            stages = 'static',
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,
        },
    },
    {
        'folke/noice.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        event = 'VeryLazy',
        opts = {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = 'msg_show',
                        any = {
                            { find = '%d+L, %d+B' },
                            { find = '; after #%d+' },
                            { find = '; before #%d+' },
                        },
                    },
                    view = 'mini',
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
        },
        keys = {
            { '<leader>sn', '', desc = '+noice' },
            {
                '<S-Enter>',
                function()
                    require('noice').redirect(vim.fn.getcmdline())
                end,
                mode = 'c',
                desc = 'Redirect Cmdline',
            },
            {
                '<leader>snl',
                function()
                    require('noice').cmd('last')
                end,
                desc = 'Noice Last Message',
            },
            {
                '<leader>snh',
                function()
                    require('noice').cmd('history')
                end,
                desc = 'Noice History',
            },
            {
                '<leader>sna',
                function()
                    require('noice').cmd('all')
                end,
                desc = 'Noice All',
            },
            {
                '<leader>snd',
                function()
                    require('noice').cmd('dismiss')
                end,
                desc = 'Dismiss All',
            },
            {
                '<leader>snt',
                function()
                    require('noice').cmd('pick')
                end,
                desc = 'Noice Picker (Telescope/FzfLua)',
            },
            {
                '<c-f>',
                function()
                    if not require('noice.lsp').scroll(4) then
                        return '<c-f>'
                    end
                end,
                silent = true,
                expr = true,
                desc = 'Scroll Forward',
                mode = { 'i', 'n', 's' },
            },
            {
                '<c-b>',
                function()
                    if not require('noice.lsp').scroll(-4) then
                        return '<c-b>'
                    end
                end,
                silent = true,
                expr = true,
                desc = 'Scroll Backward',
                mode = { 'i', 'n', 's' },
            },
        },
        config = function(_, opts)
            if vim.o.filetype == 'lazy' then
                vim.cmd([[messages clear]])
            end
            require('noice').setup(opts)
        end,
    },
}
