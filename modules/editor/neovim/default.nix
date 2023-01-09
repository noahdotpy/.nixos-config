{
  pkgs,
  lib,
  config,
  myPkgs,
  ...
}:
with lib; let
  cfg = config.modules.editor.neovim;
  vimPlugins = pkgs.vimPlugins // pkgs.tree-sitter-grammars // config.nur.repos.m15a.vimExtraPlugins // myPkgs.vimPlugins;
in {
  options.modules.editor.neovim = {enable = mkEnableOption "neovim";};

  config = mkIf cfg.enable {
    home.manager = {
      xdg.configFile = {
        "nvim" = {
          source = ./config;
          recursive = true;
        };
      };
      programs.neovim = {
        enable = true;
        extraConfig = ''
          lua require('colors')
          lua require('settings')
          lua require('mappings')
        '';
        extraPackages = with pkgs; [
          rust-analyzer
          sumneko-lua-language-server
          xclip
        ];
        plugins = with vimPlugins; [
          vim-fugitive
          vim-rhubarb
          gitsigns-nvim
          {
            plugin = comment-nvim;
            config = "lua require('Comment').setup{}";
          }
          vim-svelte
          rust-vim
          vim-polyglot
          rust-tools-nvim
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
          {
            plugin = nvim-cmp;
            config = "lua require('plugin-configs._cmp')";
          }
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp-cmdline
          cmp_luasnip
          tagalong-vim
          vim-closetag
          friendly-snippets
          luasnip
          onedark-nvim
          lualine-nvim
          {
            plugin = indent-blankline-nvim;
            config = "lua require('plugin-configs._indent-blankline')";
          }
          vim-sleuth
          telescope-nvim
          telescope-file-browser-nvim
          {
            plugin = catppuccin-nvim;
            config = "lua require('plugin-configs._catppuccin')";
          }
          tokyonight-nvim
          dashboard-nvim
          {
            plugin = bufferline-nvim;
            config = "lua require('bufferline').setup{}";
          }
          {
            plugin = nvim-lastplace;
            config = "lua require('nvim-lastplace').setup{}";
          }
          {
            plugin = which-key-nvim;
            config = "lua require('which-key').setup{}";
          }
          {
            plugin = hop-nvim;
            config = "lua require('plugin-configs._hop')";
          }
          harpoon
          telescope-fzf-native-nvim
          typescript-vim
          vim-jsx-pretty
          vim-javascript
          vimproc-vim
          tsuquyomi
          editorconfig-vim
          syntastic
          auto-pairs
        ];
      };
    };
  };
}
