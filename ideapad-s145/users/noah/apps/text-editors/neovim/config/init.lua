--------------
--- PACKER ---
--------------

-- Install packer if not already
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local is_bootstrap = ensure_packer()

-- Print a helpful message
if is_bootstrap then
  print '===================================='
  print '| Packer has been installed to     |'
  print '| your system, you can now run     |'
  print '| :PackerSync to install plugins   |'
  print '===================================='
  return
end

-- Automatically source and re-compile packer whenever you save this neovim config
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

---------------
--- MODULES ---
---------------

-- I should have more helpful messages for getting the config working
-- and also maybe bring back the packer bootstrapping over here and only require settings and mappings if bootstrap is happening to fix a bunch of "value not found" because a plugin isnt installed

if not is_bootstrap then
  require 'settings'
  require 'mappings'
end
require 'plugins'

