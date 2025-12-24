return {
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
        notify_on_error = true,
        format_on_save = false,
        formatters_by_ft = {
            lua = { 'stylua' },
            javascript = { 'biome', stop_after_first = true },
            javascriptreact = { 'biome', stop_after_first = true },
            typescript = { 'biome', stop_after_first = true },
            typescriptreact = { 'biome', stop_after_first = true },
            go = { 'goimports', 'gofmt', lsp_format = 'fallback' },
            rust = { 'rustfmt', lsp_format = 'fallback' },
        },
    },
}
