{ config, pkgs, ... }:

let
  nixpkgsConfig = if config.nixpkgs.config == null then {} else config.nixpkgs.config;
in
{

  imports =
  [
      ./associations.nix
      # ./apps/text-editors/neovim
  ];

  nixpkgs.config = {

    allowUnfree = true;
    allowUnfreePredicate = _: true;
    
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noah";
  home.homeDirectory = "/home/noah";

  programs = {

    # kitty = {
      # enable = true;
      # theme = "Tokyo Night";
      # settings = {
        # confirm_os_window_close = 0;
      # };
    # };
  };

  home.packages = [
      pkgs.vscode
      pkgs.kate
      pkgs.adw-gtk3
      
      pkgs.pazi
      pkgs.exa
      pkgs.bat
      pkgs.helix
      pkgs.ferium
      pkgs.ripgrep
      pkgs.fd
      
      pkgs.atuin
      pkgs.pfetch
      pkgs.starship
  ];
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
