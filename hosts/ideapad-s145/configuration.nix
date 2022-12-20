{
  config,
  pkgs,
  ...
}: {
  config = {
    modules = {
      system.sound.enable = true;

      # Device specific options
      device = {
        cpu = "intel";
        gpu = "intel";
        monitors = ["HDMI-A-1"]; # TODO: Probably need to change this value
        hasBluetooth = true;
        hasSound = true;
      };

      # All of the available modules are listed below
      # Uncomment/comment do enable/disable module
      # editor.neovim.enable = true;

      associations.mime.enable = true;
      associations.sessionVariables.enable = true;

      desktopenvironment.plasma.enable = true;
      displaymanager.sddm.enable = true;

      programs.cli.enable = true;
      programs.gui.enable = true;

      editor.neovim.enable = true;

      multiplexer.tmux.enable = true;
    };

    hardware.bluetooth.enable = true;

    environment.systemPackages = with pkgs; [git wget curl pinentry];

    virtualisation.podman.enable = true;

    boot = {
      # Enable the bootloader.
      initrd.verbose = false;
      consoleLogLevel = 0;
      kernelParams = ["quiet" "rd.udev.log_level=3"];
      loader = {
        systemd-boot.enable = true;
        timeout = 3;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };
      plymouth.enable = true; # Fancy loading screen at computer startup/shutdown
    };

    services.openssh = {
      enable = true;
      permitRootLogin = "no";
    };

    networking.firewall.enable = true;
  };
}
