{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktopenvironment.cinnamon;
  device = config.modules.device;
in {
  options.modules.desktopenvironment.cinnamon = {
    enable = mkEnableOption "cinnamon";
    # isDefault = mkEnableOption "set cinnamon as default display manager session";
  };

  config = mkMerge [
    (mkIf cfg.isDefault {
      # services.xserver.displayManager.defaultSession = "";
      # TODO: Implement cinnamon.isDefault
    })
    (mkIf cfg.enable {
      home.manager.xsession.enable = true;
      services.xserver.desktopManager.cinnamon.enable = true;
      environment.systemPackages = with pkgs; [
        adw-gtk3
      ];
    })
  ];
}
