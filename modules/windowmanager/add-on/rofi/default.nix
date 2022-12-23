{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.windowmanager.add-on.rofi;
in {
  options.modules.windowmanager.add-on.rofi = {
    enable = mkEnableOption "rofi";
    package = mkOption {
      default = pkgs.rofi;
      type = types.package;
    };
  };

  config = mkIf cfg.enable {
    home.manager.programs.rofi = {
      enable = true;
      package = mkIf config.modules.device.isWayland pkgs.rofi-wayland;
      extraConfig = {
        font = "Iosevka Nerd Font 12";
        width = 30;
        line-margin = 10;
        lines = 6;
        columns = 2;
        show-icons = true;
      };
      theme = ./themes/tokyonight.rasi;
    };
  };
}
