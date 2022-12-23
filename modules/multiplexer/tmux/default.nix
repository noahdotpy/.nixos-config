{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.multiplexer.tmux;
  tmuxPlugins = pkgs.tmuxPlugins;
in {
  options.modules.multiplexer.tmux = {enable = mkEnableOption "tmux";};

  config = mkIf cfg.enable {
    home.manager = {
      home.packages = with pkgs; [fzf tmuxp];
      programs.tmux = {
        enable = true;
        plugins = with tmuxPlugins; [
          copycat # https://thevaluable.dev/tmux-config-mouseless/#a-better-search-with-copycat
          extrakto # https://thevaluable.dev/tmux-config-mouseless/#fuzzy-search-with-fzf-and-extrakto
        ];
      };
      home.file.".tmux.conf".source = ./config/.tmux.conf;
    };
  };
}
