{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktopenvironment.plasma;
  device = config.modules.device;
in {
  options.modules.desktopenvironment.plasma = {
    enable = mkEnableOption "plasma";
    # isDefault = mkEnableOption "set plasmsa as default display manager session";
  };

  config = mkMerge [
    # (mkIf cfg.isDefault {
    # services.xserver.displayManager.defaultSession = "";
    # TODO: Implement plasma.isDefault
    # })
    (mkIf cfg.enable {
      home.manager.xsession.enable = true;
      services.xserver.enable = true;
      services.xserver.desktopManager.plasma5 = {
        enable = true;
        excludePackages = [
          pkgs.libsForQt5.elisa
        ];
      };
      environment.systemPackages = with pkgs; [
        libsForQt5.kamoso 
      ];
    })
  ];
}
