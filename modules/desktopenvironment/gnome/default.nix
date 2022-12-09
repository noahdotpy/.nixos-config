{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktopenvironment.gnome;
  device = config.modules.device;
in {
  options.modules.desktopenvironment.gnome = {
    enable = mkEnableOption "gnome";
    enableExtensions = mkEnableOption "gnome extensions";
    # isDefault = mkEnableOption "set gnome as default display manager session";
  };

  config = mkMerge [
    (mkIf cfg.isDefault {
      # services.xserver.displayManager.defaultSession = "";
      # TODO: Implement gnome.isDefault
    })
    (mkIf cfg.enableExtensions {
      home.manager.home.packages = with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        appindicator
        arcmenu
        battery-time
        bluetooth-quick-connect
        blur-my-shell
        clipboard-history
        custom-hot-corners-extended
        dash-to-dock
        extensions-sync
        gsconnect
        just-perfection
        lock-keys
        media-controls
        simple-system-monitor
        simply-workspaces
        snowy
      ];
    })
    (mkIf cfg.enable {
      home.manager.xsession.enable = true;
      services.xserver.desktopManager.gnome.enable = true;
      environment.systemPackages = with pkgs; [
        adw-gtk3
      ];
      environment.gnome.excludePackages =
        (with pkgs.gnome; [
          # pkgs.gnome.*
          epiphany
          evince
          geary
          gnome-contacts
          gnome-characters
          gnome-calendar
          gnome-font-viewer
          gnome-maps
          gnome-music
          gnome-shell-extensions
          gnome-weather
        ])
        ++ (with pkgs; [
          # pkgs.*
          gnome-connections
          gnome-tour
        ]);
    })
  ];
}
