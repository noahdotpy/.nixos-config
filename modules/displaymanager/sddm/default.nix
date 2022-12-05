{config, ...}:
with lib; let
  cfg = config.modules.displaymanager.sddm;
  device = config.modules.device;
in {
  options.modules.displaymanager.sddm.enable = mkEnableOption "sddm";

  config = mkIf cfg.enable {
    services.xserver.displayManager.sddm.enable = true;
  };
}
