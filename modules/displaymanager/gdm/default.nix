{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.displaymanager.gdm;
  device = config.modules.device;
in {
  options.modules.displaymanager.gdm.enable = mkEnableOption "gdm";

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
  };
}
