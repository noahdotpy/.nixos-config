-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make relative line numbers default
vim.wo.relativenumber = true
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- <TAB> settings
vim.o.expandtab = true
vim.o.smarttab = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Search as characters are entered
vim.o.incsearch = true

-- Start scrolling at N amount of lines from top or bottom of current view
vim.o.scrolloff = 5

-- Disable auto-comment when adding newline coming from commented line
vim.cmd [[autocmd FileType * set formatoptions-=cro]]

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme tokyonight-night]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.splitbelow = true -- Split below 
vim.o.splitright = true -- Split to the right

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
