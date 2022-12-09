{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.gui;
in {
  options.modules.programs.gui.enable = mkEnableOption "miscellaneous gui programs";

  config = mkIf cfg.enable {
    home.manager.home.packages = with pkgs; [
      vscode
      firefox
      vlc
      spotify
      discord
    ];
  };
}
