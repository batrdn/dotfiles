return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.12.4',
    build = 'cargo build --release',
    opts = {
        keymap = { preset = 'default' },
        completion = {
            menu = {
                border = 'rounded',
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
            },
            documentation = {
                window = {
                    border = 'rounded',
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
                },
                auto_show = true,
                auto_show_delay_ms = 500,
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        signature = { enabled = true },
    },
}

