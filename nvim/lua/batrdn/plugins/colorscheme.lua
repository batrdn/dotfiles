return {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            flavour = 'macchiato',
            background = {
                dark = 'macchiato',
            },
            integrations = {
                aerial = true,
                harpoon = true,
                neotest = true,
                grug_far = true,
                which_key = true,
                bufferline = true,
                dropbar = {
                    enabled = true,
                    color_mode = true,
                },
            },
        })

        vim.o.background = 'dark'
        vim.cmd.colorscheme('catppuccin')
    end,
}
