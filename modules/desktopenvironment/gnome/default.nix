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
    # isDefault = mkEnableOption "set gnome as default display manager session";
  };

  config = mkMerge [
    (mkIf cfg.isDefault {
      # services.xserver.displayManager.defaultSession = "";
      # TODO: Implement gnome.isDefault
    })
    (mkIf cfg.enable {
      services.xserver.desktopManager.gnome.enable = true;
      environment.systemPackages = with pkgs; [
        gnome.dconf-editor
        gnome-menus
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
