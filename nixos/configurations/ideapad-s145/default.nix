# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, ... }:

let
  nur = import inputs.nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };
in
{
  imports =
  [
    ./modules/x11
    ./modules/users/noah.nix
    ./modules/hardware-configuration.nix
  ];

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    fonts = [(pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })];
  };

  boot = {
    # Enable the bootloader.
    loader = {
      systemd-boot.enable = true;
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    plymouth.enable = true; # Fancy loading screen at computer startup/shutdown
  };

  # Enable networking
  networking = {
    hostName = "ideapad-s145";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Locales
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.utf8";

  # Services
  services = {
    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
    gnome.gnome-keyring.enable = true; # for stuff like passwords
    printing.enable = true; # enable printing support with CUPS
    flatpak.enable = true;
  };
  
  programs = {
    ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
    dconf.enable = true;
    zsh.enable = true;
    neovim.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable virtualisation.
  virtualisation.libvirtd.enable = true;

  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Custom nix options
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Packages you want to be installed in the system profile.
  environment.systemPackages = [
    pkgs.wget
    pkgs.curl
    pkgs.git

    pkgs.pinentry
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
