{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      vim-rhubarb
      gitsigns-nvim
      comment-nvim
      nvim-treesitter
      nvim-lspconfig
      nvim-cmp
      luasnip
      onedark-nvim
      lualine-nvim
      indent-blankline-nvim
      vim-sleuth
      telescope-nvim
      telescope-file-browser-nvim
      catppuccin-nvim
      tokyonight-nvim
      dashboard-nvim
      bufferline-nvim
      nvim-lastplace
      pears-nvim
      which-key-nvim
      hop-nvim
      telescope-fzf-native-nvim
      typescript-vim
      vim-jsx-pretty
      vim-javascript
      vimproc-vim
      tsuquyomi
      YouCompleteMe
      editorconfig-vim
      syntastic
      auto-pairs
    ];
  };
}
