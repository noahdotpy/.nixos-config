{pkgs, ...}:
{
  services.xserver.desktopManager.plasma5.excludePackages = [
    pkgs.libsForQt5.elisa
  ];
}
{pkgs, ...}:
{
}
{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktopenvironment.plasm;
  device = config.modules.device;
in {
  options.modules.desktopenvironment.plasma = {
    enable = mkEnableOption "plasma";
    # isDefault = mkEnableOption "set plasmsa as default display manager session";
  };

  config = mkMerge [
    (mkIf cfg.isDefault {
      # services.xserver.displayManager.defaultSession = "";
      # TODO: Implement plasma.isDefault
    })
    (mkIf cfg.enable {
      services.xserver.desktopManager.plasma = {
        enable = true;
        excludePackages = [
          pkgs.libsForQt5.elisa
        ];
      };
    })
  ];
}
