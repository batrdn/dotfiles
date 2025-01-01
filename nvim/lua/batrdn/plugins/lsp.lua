return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        { 'j-hui/fidget.nvim', opts = {} },
        { 'folke/lazydev.nvim', opts = {} },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'saghen/blink.cmp',
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')

                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                map('gpd', require('goto-preview').goto_preview_definition, '[G]oto [P]review [D]efinition')
                map('gpt', require('goto-preview').goto_preview_type_definition, '[G]oto [P]review [T]ype [D]efinition')
                map('gpi', require('goto-preview').goto_preview_implementation, '[G]oto [P]review [I]mplementation')
                map('gpD', require('goto-preview').goto_preview_declaration, '[G]oto [P]review [D]eclaration')
                map('gpr', require('goto-preview').goto_preview_references, '[G]oto [P]review [R]efrences')
                map('gP', require('goto-preview').close_all_win, 'Preview Close All Windows')

                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
                        end,
                    })
                end

                if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

        local nvim_lsp = require('lspconfig')

        local servers = {
            denols = {
                root_dir = nvim_lsp.util.root_pattern('deno.json', 'deno.jsonc'),
            },
            ts_ls = { root_dir = nvim_lsp.util.root_pattern('package.json'), single_file_support = false },
            clangd = {},
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                        diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
        }

        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
            'typescript-language-server',
            'prettier',
        })

        require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

        require('mason-lspconfig').setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        })
    end,
}
