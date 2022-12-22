{
  pkgs,
  lib,
  config,
  myPkgs,
  ...
}:
with lib; let
  cfg = config.modules.editor.neovim;
  vimPlugins = pkgs.vimPlugins // pkgs.tree-sitter-grammars // config.nur.repos.m15a.vimExtraPlugins // myPkgs.nvim-plugins;
in {
  options.modules.editor.neovim = {enable = mkEnableOption "neovim";};

  config = mkIf cfg.enable {
    home.manager = {
      xdg.configFile = {
        "nvim" = {
          source = ./config;
          recursive = true;
        };
        "nvim/lua" = {
          source = ./config/lua;
          recursive = true;
        };
      };
      programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
          rust-analyzer
        ];
        plugins = with vimPlugins; [
          vim-fugitive
          vim-rhubarb
          gitsigns-nvim
          comment-nvim
          vim-svelte
          coc-svelte
          coc-rust-analyzer
          coc-rls
          rust-vim
          vim-polyglot
          rust-tools-nvim
          filetype-nvim
          (nvim-treesitter.withPlugins (plugins:
            with plugins; [
              tree-sitter-svelte
              tree-sitter-rust
              tree-sitter-bash
              tree-sitter-comment
              tree-sitter-dockerfile
              tree-sitter-fish
              tree-sitter-go
              tree-sitter-html
              tree-sitter-json
              tree-sitter-json5
              tree-sitter-lua
              tree-sitter-nix
              tree-sitter-python
              tree-sitter-regex
              tree-sitter-typescript
              tree-sitter-vim
              tree-sitter-yaml
            ]))
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
    };
  };
}
