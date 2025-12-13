return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'catppuccin',
                icons_enabled = true,
                component_separators = '|',
                section_separators = { left = "", right = "" },
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
                lualine_z = {},
            },
        })
    end,
}
