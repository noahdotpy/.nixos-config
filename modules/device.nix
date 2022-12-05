{
  pkgs,
  config,
  lib,
  myConfig,
  ...
}:
with lib; {
  options.modules.device = {
    # Options below NEED to be set on each host
    cpu = mkOption {
      type = types.enum ["amd" "intel" "vm"];
    };
    gpu = mkOption {
      type = types.enum ["amd" "intel" "nvidia" "vm"];
    };
    monitors = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    hasBluetooth = mkOption {
      type = types.bool;
    };
    hasSound = mkOption {
      type = types.bool;
    };

    # Options below DON't NEED to be set, will be set by automatically
    hostname = mkOption {
      type = types.str;
      default = myConfig.hostname;
    };
    username = mkOption {
      type = types.str;
      default = myConfig.username;
    };
    isWayland = mkOption {
      type = types.bool;
      default = false;
    };
  };
}
