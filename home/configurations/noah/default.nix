{ pkgs, ... }:
{
  # home-manager.users."noah" = import ./home.nix;

  # users.users = {
  #   noah = {
  #     isNormalUser = true;
  #     initialPassword = "temp";
  #     extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  #     shell = pkgs.zsh;
  #   };
  # };
  imports = [ ./home.nix ];
}