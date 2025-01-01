return {
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('oil').setup({
                lsp_file_methods = {
                    enabled = true,
                    autosave_changes = true,
                },
                view_options = {
                    show_hidden = true,
                    -- TODO: define always hidden
                },
            })

            vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
            vim.keymap.set('n', '<leader>-', require('oil').toggle_float)
        end,
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require('harpoon')
            harpoon.setup({})

            vim.keymap.set('n', '<leader>a', function()
                harpoon:list():add()
            end)
            vim.keymap.set('n', '<leader>rm', function()
                harpoon:list():remove()
            end)
            vim.keymap.set('n', '<leader>cL', function()
                harpoon:list():clear()
            end)
            vim.keymap.set('n', '<M-e>', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = 'Open harpoon window' })
        end,
    },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false,
        cmd = {
            'TmuxNavigateLeft',
            'TmuxNavigateDown',
            'TmuxNavigateUp',
            'TmuxNavigateRight',
        },
        keys = {
            { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
            { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
            { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
            { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
        },
    },
}
