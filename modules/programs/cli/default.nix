{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.cli;
in {
  options.modules.programs.cli.enable = mkEnableOption "miscellaneous cli programs";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    home.manager.home.packages = with pkgs; [
      tig

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
  };
}
