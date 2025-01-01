return {
    {
        'rmagatti/goto-preview',
        event = 'BufEnter',
        config = true,
    },
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    { 'numToStr/Comment.nvim', opts = {} },
    {
        'windwp/nvim-ts-autotag',
        opts = {},
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            {
                'm',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                '<leader>S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                'R',
                mode = { 'o', 'x' },
                function()
                    require('flash').treesitter_search()
                end,
                desc = 'Treesitter Search',
            },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },
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
    -- TODO: configure snippets
    {
        'MagicDuck/grug-far.nvim',
        opts = {
            headerMaxWidth = 80,
        },
        cmd = 'GrugFar',
        keys = {

            {
                '<leader>sR',
                function()
                    local grug = require('grug-far')
                    local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
                        },
                    })
                end,
                mode = { 'n', 'v' },
                desc = 'Search and Replace',
            },
            {
                '<leader>sW',
                function()
                    require('grug-far').open({
                        transient = true,
                        prefills = {
                            search = vim.fn.expand('<cword>'),
                        },
                    })
                end,
                mode = { 'n', 'v' },
                desc = 'Search and Replace Current Word',
            },
        },
    },
    'tpope/vim-sleuth',
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
    { -- Code Formatting
        'stevearc/conform.nvim',
        lazy = false,
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format({ async = true, lsp_fallback = true })
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                javascript = { { 'prettierd', 'prettier' } },
                typescript = { { 'prettierd', 'prettier' } },
            },
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        build = 'cargo build --release',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },
            signature = { enabled = true },
        },
    },
    -- { -- Autocompletion
    --     'hrsh7th/nvim-cmp',
    --     event = 'InsertEnter',
    --     dependencies = {
    --         {
    --             'L3MON4D3/LuaSnip',
    --             build = (function()
    --                 if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
    --                     return
    --                 end
    --                 return 'make install_jsregexp'
    --             end)(),
    --         },
    --         'saadparwaiz1/cmp_luasnip',
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-path',
    --     },
    --     config = function()
    --         local cmp = require('cmp')
    --         local luasnip = require('luasnip')
    --         luasnip.config.setup({})
    --
    --         cmp.setup({
    --             snippet = {
    --                 expand = function(args)
    --                     luasnip.lsp_expand(args.body)
    --                 end,
    --             },
    --             completion = { completeopt = 'menu,menuone,noinsert' },
    --
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<C-n>'] = cmp.mapping.select_next_item(),
    --                 ['<C-p>'] = cmp.mapping.select_prev_item(),
    --                 ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --                 ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --                 ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    --                 ['<C-Space>'] = cmp.mapping.complete({}),
    --                 ['<C-l>'] = cmp.mapping(function()
    --                     if luasnip.expand_or_locally_jumpable() then
    --                         luasnip.expand_or_jump()
    --                     end
    --                 end, { 'i', 's' }),
    --                 ['<C-h>'] = cmp.mapping(function()
    --                     if luasnip.locally_jumpable(-1) then
    --                         luasnip.jump(-1)
    --                     end
    --                 end, { 'i', 's' }),
    --             }),
    --             sources = {
    --                 { name = 'nvim_lsp' },
    --                 { name = 'luasnip' },
    --                 { name = 'path' },
    --             },
    --         })
    --     end,
    -- },
}
