{ config, pkgs, ... }:
let
  layout = "au";
  xkbVariant = "";
  excludePkgs = (with pkgs.gnome; [
    # pkgs.gnome.*
    epiphany evince geary
    gnome-contacts gnome-characters
    gnome-calendar gnome-font-viewer gnome-maps
    gnome-music gnome-shell-extensions gnome-weather
  ]) ++ (with pkgs; [
    # pkgs.*
    gnome-connections gnome-tour 
  ]);
in
{
  # Desktop Environment stuff
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    layout = "au";
    xkbVariant = "";
  };
  environment.gnome.excludePackages = excludePkgs;
}