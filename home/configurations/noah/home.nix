{
  config,
  pkgs,
  ...
}: let
  nixpkgsConfig =
    if config.nixpkgs.config == null
    then {}
    else config.nixpkgs.config;
in {
  imports = [
    ./modules/associations.nix
    ./modules/programs/packages.nix
    ./modules/programs/neovim.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noah";
  home.homeDirectory = "/home/noah";

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
