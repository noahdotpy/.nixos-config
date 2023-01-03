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
    };
    home.manager.xdg.configFile."rofi" = {
      source = ./config;
      recursive = true;
    };
  };
}
