vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Clear search highlights on ESC
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+yg_', { desc = 'Copy line to clipboard without newline' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Copy current line to clipboard' })

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste from clipboard before the cursor' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set('v', '<leader>P', '"+P', { desc = 'Paste from clipboard before the cursor' })

-- Map Ctrl-Up to move the current line up
vim.api.nvim_set_keymap('n', '<A-Up>', ':m -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Map Ctrl-Down to move the current line down
vim.api.nvim_set_keymap('n', '<A-Down>', ':m +1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Navigating buffers
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { desc = 'Go to [P]revious [B]uffer' })
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { desc = 'Go to [N]ext [B]uffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete [B]uffer' })

-- VSCode formatter
if vim.g.vscode then
    vim.keymap.set('n', '<leader>f', '<Cmd>call VSCodeNotify("editor.action.formatDocument")<CR>', { desc = '[F]ormat document' })
end
