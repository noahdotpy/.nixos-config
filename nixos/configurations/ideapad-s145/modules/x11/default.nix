{
  imports = [ 
    ./de/plasma/extra-settings.nix
  ];
  services.xserver = {
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
    
    # Configure keymap in X11
    layout = "au";
    xkbVariant = "";
    
    enable = true;

  };
}
