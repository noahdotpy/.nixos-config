# Always add to this file when adding new module
{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    # Device options
    ./device.nix
    # Home manager alias
    ./home-manager.nix
    ./editor/neovim

    ./multiplexer/tmux

    ./system/cpu
    ./system/font
    ./system/sound
    ./system/video

    ./terminal-emulator/kitty

    ./windowmanager/i3
    ./windowmanager/sway
    ./windowmanager/add-on/blueman-applet
    ./windowmanager/add-on/dunst
    ./windowmanager/add-on/gnome-keyring
    ./windowmanager/add-on/nm-applet
    ./windowmanager/add-on/pasystray
    ./windowmanager/add-on/picom
    ./windowmanager/add-on/py3status
    ./windowmanager/add-on/rofi
    ./windowmanager/add-on/thunar
    ./windowmanager/add-on/waybar
    ./windowmanager/add-on/xdg

    ./desktopenvironment/gnome
    ./desktopenvironment/plasma

    ./displaymanager/sddm

    ./programs/cli
    ./programs/gui
  ];
}
