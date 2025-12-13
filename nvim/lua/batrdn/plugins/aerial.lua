return {
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
}