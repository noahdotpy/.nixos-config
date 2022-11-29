-- See `:help vim.keymap.set()`

------------------------
--- => GENERAL <= ----
------------------------

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

----------------------------
--- => DISABLED KEYS <= ----
----------------------------

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Disable the arrow keys
-- vim.keymap.set({ 'n', 'v' }, '<Up>', '<Nop>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<Down>', '<Nop>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<Left>', '<Nop>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<Right>', '<Nop>', { silent = true })

--------------------------
--- => FILE CONTENT <= ---
--------------------------

vim.keymap.set('n', '<S-Tab>', '<<', { silent = true, desc = '[Shift+Tab] Unindent line' })
vim.keymap.set('n', '<Tab>', '>>', { silent = true, desc = '[Tab] Indent line' })

-- System clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = '[Leader+y] Yank to system clipboard' })
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { silent = true, desc = '[Leader+p] Paste from system clipboard' })

------------------------
--- => UI TOGGLES <= ---
------------------------

vim.keymap.set('n', '<leader>e', '<CMD>NvimTreeToggle<CR>', { silent = true })

-- TELESCOPE KEYBINDS
-- See `:help telescope.builtin`

vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[fr] Find recently opened files' })
vim.keymap.set('n', '<leader>fb', require "telescope".extensions.file_browser.file_browser, { desc = '[fb] Open file browser' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[ff] Find files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

------------------
--- => FILE <= ---
------------------

vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true }) -- Save current buffer
vim.keymap.set('n', '<C-M-s>', ':wa<CR>', { silent = true }) -- Save all buffers
vim.keymap.set('n', '<C-q>', ':wqa<CR>', { silent = true }) -- Save all buffers and close

--------------------
--- => SPLITS <= ---
--------------------

-- Navigate splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

--------------------
--- => FIXES <= ---
--------------------

-- Line wrapping navigation fix
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

------------------------
--- => DIAGNOSTIC <= ---
------------------------

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

