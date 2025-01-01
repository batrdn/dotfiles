return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'theHamsta/nvim-dap-virtual-text',
        'jay-babu/mason-nvim-dap.nvim',
        {
            'mxsdev/nvim-dap-vscode-js',
            dependencies = {
                'microsoft/vscode-js-debug',
                version = '1.x',
                build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
            },
        },
    },
    keys = function(_, keys)
        local dap = require('dap')
        local dapui = require('dapui')
        return {
            { '<leader>dc', dap.continue, desc = 'Debug: Start/Continue' },
            { '<C-Down>', dap.step_into, desc = 'Debug: Step Into' },
            { '<C-Right>', dap.step_over, desc = 'Debug: Step Over' },
            { '<C-Left>', dap.step_out, desc = 'Debug: Step Out' },
            { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
            { '<leader>ds', dap.terminate, desc = 'Debug: Stop' },
            { '<leader>bc', dap.clear_breakpoints, desc = 'Debug: Clear All Breapoints' },
            {
                '<leader>B',
                function()
                    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
                end,
                desc = 'Debug: Set Breakpoint',
            },
            { '<leader>dl', dapui.toggle, desc = 'Debug: See last session result.' },
            unpack(keys),
        }
    end,
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        local dap_vt = require('nvim-dap-virtual-text')

        dap_vt.setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            filter_references_pattern = '<module',
            virt_text_pos = 'inline',
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        })

        vim.g.dap_virtual_text = true

        require('mason-nvim-dap').setup({
            automatic_installation = true,
            handlers = {},
            ensure_installed = {
                'js-debug-adapter',
            },
        })

        require('dap-vscode-js').setup({
            debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
            adapters = { 'pwa-node' },
        })

        local languages = {
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
        }

        for _, language in ipairs(languages) do
            dap.configurations[language] = {
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch Current File (pwa-node)',
                    cwd = vim.fn.getcwd(),
                    args = { '${file}' },
                    sourceMaps = true,
                    protocol = 'inspector',
                    runtimeExecutable = 'npm',
                },
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch Current File (pwa-node with ts-node)',
                    cwd = vim.fn.getcwd(),
                    runtimeArgs = { '--loader', 'ts-node/esm' },
                    runtimeExecutable = 'node',
                    args = { '${file}' },
                    sourceMaps = true,
                    protocol = 'inspector',
                    skipFiles = { '<node_internals>/**', 'node_modules/**' },
                    resolveSourceMapLocations = {
                        '${workspaceFolder}/**',
                        '!**/node_modules/**',
                    },
                },
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch Test Current File (pwa-node with jest)',
                    cwd = vim.fn.getcwd(),
                    runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
                    runtimeExecutable = 'node',
                    args = { '${file}', '--coverage', 'false' },
                    rootPath = '${workspaceFolder}',
                    sourceMaps = true,
                    console = 'integratedTerminal',
                    internalConsoleOptions = 'neverOpen',
                    skipFiles = { '<node_internals>/**', 'node_modules/**' },
                },
                {
                    type = 'pwa-node',
                    request = 'attach',
                    name = 'Attach Program (pwa-node, select pid)',
                    cwd = vim.fn.getcwd(),
                    processId = require('dap.utils').pick_process,
                    skipFiles = { '<node_internals>/**' },
                },
            }
        end

        dapui.setup({
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { '<CR>', '<2-LeftMouse>' },
                open = 'o',
                remove = 'd',
                edit = 'e',
                repl = 'r',
                toggle = 't',
            },
            layouts = {
                {
                    elements = {
                        'watches',
                        'breakpoints',
                        { id = 'scopes', size = 0.33 },
                    },
                    size = 50,
                    position = 'left',
                },
                {
                    elements = {
                        'repl',
                        'console',
                    },
                    size = 0.25,
                    position = 'bottom',
                },
            },
            floating = {
                max_height = nil,
                max_width = nil,
                border = 'rounded',
                mappings = {
                    close = { 'q', '<Esc>' },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil,
            },
        })

        vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = 'DapLogPoint' })
        vim.fn.sign_define(
            'DapStopped',
            { text = ' ', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' }
        )

        dap.set_log_level('TRACE')

        dap.listeners.before.attach['dapui_config'] = function()
            dapui.open()
        end
        dap.listeners.before.launch['dapui_config'] = function()
            dapui.open()
        end
        dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
        end
    end,
}
