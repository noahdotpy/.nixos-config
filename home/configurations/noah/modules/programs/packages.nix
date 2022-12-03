{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    vlc

    gnome.dconf-editor
    gnome-menus # needed for arc menu extension to work

    vscode
    adw-gtk3

    pazi
    exa
    bat
    helix
    ferium
    ripgrep
    fd

    atuin
    pfetch
    starship
    htop
    direnv
  ];
}
