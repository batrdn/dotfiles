require('batrdn.keymaps')
if vim.g.vscode then
    -- VSCode extension
else
    require('batrdn.autocmds')
    require('batrdn.lazy')
    require('batrdn.options')
end
