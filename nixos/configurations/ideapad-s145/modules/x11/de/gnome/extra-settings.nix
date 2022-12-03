{ pkgs, ... }:
{
  environment.gnome.excludePackages = (with pkgs.gnome; [
    # pkgs.gnome.*
    epiphany evince geary
    gnome-contacts gnome-characters
    gnome-calendar gnome-font-viewer gnome-maps
    gnome-music gnome-shell-extensions gnome-weather
  ]) ++ (with pkgs; [
    # pkgs.*
    gnome-connections gnome-tour 
  ]);
}

