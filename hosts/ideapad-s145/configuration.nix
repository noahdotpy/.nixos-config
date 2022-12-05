{
  config,
  pkgs,
  ...
}: {
  config = {
    modules = {
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

      multiplexer.tmux.enable = true;

      desktopenvironment.gnome.enable = true;
      displaymanager.gdm.enable = true;

      programs.cli.enable = true;
      programs.gui.enable = true;

      editor.neovim.enable = true;

      terminal-emulator.kitty.enable = true;
    };

    environment.systemPackages = with pkgs; [git wget curl pinentry];

    boot = {
      # Enable the bootloader.
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
