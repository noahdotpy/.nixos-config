{
  config,
  pkgs,
  inputs,
  ...
}: let
  deviceCfg = config.modules.device;
in {
  users.users.${deviceCfg.username} = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio"];
    shell = pkgs.zsh;
  };

  networking.hostName = deviceCfg.hostname;

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.utf8";

  security.polkit.enable = true;

  # Programs that should always be needed
  # modules.program.tui-utils.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config.allowUnfree = true;
  system = {
    autoUpgrade = {
      enable = true;
      flake = builtins.toString ../.;
      operation = "boot";
    };
    stateVersion = "22.05";
  };

  home.manager = {
    home = {
      username = deviceCfg.username;
      homeDirectory = "/home/" + deviceCfg.username;

      stateVersion = "22.05";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}
