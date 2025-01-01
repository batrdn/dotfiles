local opt = vim.opt

vim.g.have_nerd_font = true

-- Clipboard settings for yanking to system clipboard
vim.schedule(function()
    opt.clipboard = 'unnamedplus'
end)

opt.relativenumber = true

-- Enable mouse mode, useful for resizing window
opt.mouse = 'a'

-- Determines whether pressing the Tab key inserts a tab character '\t' or a specific number of spaces
opt.expandtab = true

-- Indentation size
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Insert indents automatically
opt.smartindent = true

-- Indents wrapped lines
opt.breakindent = true

-- Show the line number
opt.number = true

-- Displays the current mode
opt.showmode = true

-- Ignore cases when searching
opt.ignorecase = true
opt.smartcase = true

-- Decrease the time to write to swap file and updating CursorHold events
opt.updatetime = 250

-- Decrease the maximum time to wait for a key sequence to complete in mappigns
opt.timeoutlen = 300

-- Set the behavior for splitting windows
opt.splitright = true
opt.splitbelow = true

-- Show invisible characters
opt.list = true
opt.listchars = { tab = '▸ ', trail = '·' }

-- Show the preview of substitutions
opt.inccommand = 'split'

-- Highlight the current cursor position in respect to the line number
opt.cursorline = true

-- The number of lines maintained above/below the cursor
opt.scrolloff = 5

-- Highlight search results
opt.hlsearch = true
opt.incsearch = true

-- Automatically saves files when switching to an another buffer
opt.autowrite = true

-- Confirm whether to save changes or not before exiting modified buffer
opt.confirm = true

-- Whether to save undo history an external file
opt.undofile = true
opt.undolevels = 10000

-- Allows the cursor to move freely in visual mode
opt.virtualedit = 'block'

-- Provides a dedicated space for displaying signs like lint messages, version control indicators or debug breakpoints next to the line
opt.signcolumn = 'yes'

if vim.fn.has('nvim-0.10') == 1 then
    opt.smoothscroll = true
end
