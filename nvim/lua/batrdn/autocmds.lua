vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    desc = 'Custom color overrides',
    callback = function()
        vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#ed8796' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#91d7e3' })
        vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#a6da95' })
        vim.api.nvim_set_hl(0, 'NvimDapVirtualText', { ctermbg = 0, fg = '#f4dbd6' })
        vim.api.nvim_set_hl(0, 'DropBarMenuSbar', { fg = '#aaaaaa', bg = 'NONE' })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
    pattern = {
        'checkhealth',
        'gitsigns-blame',
        'grug-far',
        'help',
        'lspinfo',
        'neotest-output',
        'neotest-output-panel',
        'neotest-summary',
        'notify',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set('n', 'q', function()
                vim.cmd('close')
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = 'Quit buffer',
            })
        end)
    end,
})
