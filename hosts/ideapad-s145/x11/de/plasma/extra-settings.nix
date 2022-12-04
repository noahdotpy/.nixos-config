{pkgs, ...}: {
  services.xserver.desktopManager.plasma5.excludePackages = with pkgs; [
    pkgs.libsForQt5.elisa
  ];
}
