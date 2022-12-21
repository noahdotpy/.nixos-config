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

-----------------------------
--- => FILE NAVIGATION <= ---
-----------------------------

-- requires plugin github:phaazon/hop.nvim
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})

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

-- TELESCOPE KEYBINDS
-- See `:help telescope.builtin`

vim.keymap.set('n', '<leader>fr',       require('telescope.builtin').oldfiles,                      { desc = '[<space>fr] Find recently opened files' })
vim.keymap.set('n', '<leader>fb',       require('telescope').extensions.file_browser.file_browser,  { desc = '[<space>fb] File browser' })
vim.keymap.set('n', '<leader>ff',       require('telescope.builtin').find_files,                    { desc = '[<space>ff] Find files' })

vim.keymap.set('n', '<leader>gff', require('telescope.builtin').git_files, { desc = '[<space>gff] Git: Find tracked file' })

vim.keymap.set('n', '<leader>bf',       require('telescope.builtin').buffers,                       { desc = '[<space>bf] Search existing buffers' })
vim.keymap.set('n', '<leader>btn',       '<CMD>bnext<cr>',                                          { desc = '[<space>btn] To next buffer' })
vim.keymap.set('n', '<leader>btp',       '<CMD>bprevious<cr>',                                      { desc = '[<space>btp] To previous buffer' })

vim.keymap.set('n', '<leader>sb', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[<space>sb] Search in current buffer]' })
vim.keymap.set('n', '<leader>st',       require('telescope.builtin').treesitter,                    { desc = '[<space>st] Search through treesitter symbols' })
vim.keymap.set('n', '<leader>sh',       require('telescope.builtin').help_tags,                     { desc = '[<space>sh] Search help' })
vim.keymap.set('n', '<leader>sw',       require('telescope.builtin').grep_string,                   { desc = '[<space>sw] Search current word' })
vim.keymap.set('n', '<leader>sg',       require('telescope.builtin').live_grep,                     { desc = '[<space>sg] Search by grep' })
vim.keymap.set('n', '<leader>sd',       require('telescope.builtin').diagnostics,                   { desc = '[<space>sd] Search diagnostics' })

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

-----------------
--- => LSP <= ---
-----------------

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>r', vim.lsp.buf.rename, '[<space>r] LSP: Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting, { desc = 'Format current buffer with LSP' })
end

