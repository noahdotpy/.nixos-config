{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktopenvironment.xfce;
  device = config.modules.device;
in {
  options.modules.desktopenvironment.xfce = {
    enable = mkEnableOption "xfce";
    disableXfwm = mkEnableOption "disable xfwm. this is useful if you are using something like i3wm with xfce instead.";
    # isDefault = mkEnableOption "set xfce as default display manager session";
  };

  config = mkMerge [
    # (mkIf cfg.isDefault {
    # services.xserver.displayManager.defaultSession = "";
    # TODO: Implement xfce.isDefault
    # })
    (mkIf cfg.disableXfwm {
      services.xserver.desktopManager.xfce.enableXfwm = false;
    })
    (mkIf cfg.enable {
      home.manager.xsession.enable = true;
      services.xserver.enable = true;
      services.xserver.desktopManager.xfce.enable = true;
      environment.systemPackages = with pkgs; [adw-gtk3 xfce.xfce4-whiskermenu-plugin];
    })
  ];
}
