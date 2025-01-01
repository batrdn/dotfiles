return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'VeryLazy',
        opts = {
            mode = 'cursor',
            multiline_threshold = 3,
        },
        config = function(_, opts)
            require('treesitter-context').setup(opts)
            vim.cmd([[ highlight TreesitterContextBottom gui=none]])
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                'c',
                'cpp',
                'zig',
                'go',
                'rust',
                'jsdoc',
                'javascript',
                'typescript',
                'python',
                'lua',
                'luadoc',
                'bash',
                'html',
                'css',
                'yaml',
                'xml',
                'toml',
                'regex',
                'json',
                'markdown',
                'dockerfile',
                'cmake',
                'graphql',
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['aF'] = '@call.outer',
                        ['iF'] = '@call.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['ab'] = '@block.outer',
                        ['ib'] = '@block.inner',
                        ['al'] = '@loop.outer',
                        ['il'] = '@loop.inner',
                        ['ai'] = '@conditional.outer',
                        ['ii'] = '@conditional.inner',
                        ['ap'] = '@parameter.outer',
                        ['ip'] = '@parameter.inner',
                        ['aC'] = '@comment.outer',
                        ['a='] = '@assignment.outer',
                        ['i='] = '@assignment.inside',
                        ['=r'] = '@assignment.rhs',
                        ['=l'] = '@assignment.lhs',
                    },

                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                        ['@function.outer'] = 'V',
                        ['@class.outer'] = '<c-v>',
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>np'] = '@parameter.inner',
                        ['<leader>nf'] = '@function.outer',
                    },
                    swap_previous = {
                        ['<leader>pp'] = '@parameter.inner',
                        ['<leader>pf'] = '@function.outer',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']l'] = '@loop.outer',
                        [']s'] = '@local.scope',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                        ['[l'] = '@loop.outer',
                        ['[s'] = '@local.scope',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                    },
                    -- goto_next = {
                    --     [']d'] = '@conditional.outer',
                    -- },
                    -- goto_previous = {
                    --     ['[d'] = '@conditional.outer',
                    -- },
                },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
            local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

            vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)
        end,
    },
}
