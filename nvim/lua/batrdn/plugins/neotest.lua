---@diagnostic disable: missing-fields
return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'folke/trouble.nvim',
            'nvim-neotest/neotest-jest',
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-jest')({
                        jestCommand = 'npm test --',
                        env = { CI = true },
                        cwd = function()
                            return vim.fn.getcwd()
                        end,
                    }),
                },
                quickfix = {
                    open = function()
                        require('trouble.nvim').open({ mode = 'quickfix', focus = false })
                    end,
                },
                diagnostic = { enabled = true },
                highlights = {
                    adapter_name = 'NeotestAdapterName',
                    border = 'NeotestBorder',
                    dir = 'NeotestDir',
                    expand_marker = 'NeotestExpandMarker',
                    failed = 'NeotestFailed',
                    file = 'NeotestFile',
                    focused = 'NeotestFocused',
                    indent = 'NeotestIndent',
                    namespace = 'NeotestNamespace',
                    passed = 'NeotestPassed',
                    running = 'NeotestRunning',
                    skipped = 'NeotestSkipped',
                    test = 'NeotestTest',
                },
                icons = {
                    child_indent = '│',
                    child_prefix = '├',
                    collapsed = '─',
                    expanded = '╮',
                    failed = '✖',
                    final_child_indent = ' ',
                    final_child_prefix = '╰',
                    non_collapsible = '─',
                    passed = '✔',
                    running = '',
                    skipped = 'ﰸ',
                    unknown = '?',
                },
                output = { enabled = true, open_on_run = true },
                run = { enabled = true },
                status = { enabled = true },
                strategies = { integrated = { height = 40, width = 120 } },
                summary = {
                    enabled = true,
                    expand_errors = true,
                    follow = true,
                    -- stylua: ignore
                    mappings = {
                        attach = 'a', expand = { '<CR>', '<2-LeftMouse>' }, expand_all = 'e',
                        jumpto = 'i', output = 'o', run = 'r', short = 'O', stop = 'u',
                    },
                },
            })
        end,
        -- stylua: ignore
        keys = {
            { '<leader>tt', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run the current file tests' },
            { '<leader>tr', function() require('neotest').run.run() end, desc = 'Run the nearest test' },
            { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Debug the nearest test' },
            { '<leader>tl', function() require('neotest').run.run_last() end, desc = 'Run the last test' },
            { '<leader>tL', function() require('neotest').run.run_last({ strategy = 'dap' }) end, desc = 'Debug the last test' },
            { '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end, desc = 'Show output' },
            { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle summary' },
        },
    },
}
