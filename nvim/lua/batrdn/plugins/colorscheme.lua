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
            no_italic = true, 
            no_bold = true,
            no_underline = false,
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
