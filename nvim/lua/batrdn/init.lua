require('batrdn.keymaps')
if vim.g.vscode then
    vim.keymap.set('n', 'gr', '<Cmd>call VSCodeNotify("editor.action.goToReferences")<CR>', { desc = 'Find references' })
    vim.keymap.set('n', '<leader>rn', '<Cmd>call VSCodeNotify("editor.action.rename")<CR>', { desc = '[R]e[n]ame' })
    vim.keymap.set('n', 'K', '<Cmd>call VSCodeNotify("editor.action.peekDefinition")<CR>', { desc = 'Peek definition' })
else
    require('batrdn.autocmds')
    require('batrdn.lazy')
    require('batrdn.options')
end
