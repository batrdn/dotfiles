return {
    {
        'sindrets/diffview.nvim',
        config = function()
            require('diffview').setup()

            vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>')
            vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<CR>')
            vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory<CR>')

            vim.cmd('cnoreabbrev dfo DiffviewOpen')
            vim.cmd('cnoreabbrev dfh DiffviewFileHistory')
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require('gitsigns')

            gitsigns.setup({
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked = { text = '┆' },
                },
                signs_staged = {
                    add = { text = '┃' },
                    change = { text = '┃' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked = { text = '┆' },
                },
                numhl = true,
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 250,
                },
            })

            local function map(mode, l, r, opts)
                opts = opts or {}
                vim.keymap.set(mode, l, r, opts)
            end

            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end)

            map('n', '<leader>hs', gitsigns.stage_hunk)
            map('n', '<leader>hr', gitsigns.reset_hunk)
            map('v', '<leader>hs', function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)
            map('v', '<leader>hr', function()
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)
            map('n', '<leader>hS', gitsigns.stage_buffer)
            map('n', '<leader>hR', gitsigns.reset_buffer)
            map('n', '<leader>hu', gitsigns.undo_stage_hunk)
            map('n', '<leader>hp', gitsigns.preview_hunk)
            map('n', '<leader>gb', function()
                gitsigns.blame_line({ full = true })
            end)
        end,
    },
}
