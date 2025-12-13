return {
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
}
