# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
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
    ./hardware-configuration.nix  # Include the results of the hardware scan.
    ./users/noah              # Enables user: noah
  ];

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    fonts = [
      (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };

  boot = {

    # Enable the bootloader.
    loader = {

      systemd-boot = {
        enable = true;
      };

      # grub = {
      #   enable = true;
      #   efiSupport = true;
      #   device = "nodev";
      #   efiInstallAsRemovable = true;
      # };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 5;
    };
    
    # Fancy loading screen showing up instead of hacker man text
    plymouth.enable = true; 

  };

  networking = {

    hostName = "ideapad-s145";

    # Enable networking
    networkmanager.enable = true;

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];

    firewall.enable = true;

  };
  

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.utf8";

  # Custom nix options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Enable the X11 windowing system.
  services = {

    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
    
    # Enable gnome keyring.
    gnome.gnome-keyring.enable = true;

    # Enable the OpenSSH daemon.
    # openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable flatpak.
    flatpak.enable = true;

    xserver = {
      
      enable = true;

      # Configure keymap in X11
      layout = "au";
      xkbVariant = "";
      
      displayManager = {
        # sddm.enable = true;
        gdm.enable = true;
      };
      desktopManager = {
        gnome.enable = true;
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

  };


  programs = {

    ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      # enableSSHSupport = true;
    };

    dconf.enable = true;

    zsh = {
      enable = true;
    };

    neovim.enable = true;

  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  systemd.services.blueman.serviceConfig = {
    Environment = "DISPLAY=:0.0";
  };

  # Enable virtualisation.
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;

  # Change mouse and touchpad settings for X11
  services.xserver.libinput = {
    enable = true;

    mouse = {
      accelProfile = "flat"; 
      naturalScrolling = false;
    };
    touchpad = {
      accelProfile = "flat";
      naturalScrolling = true;
      sendEventsMode = "disabled-on-external-mouse";
    };
  };

  # Define a user account. Don't forget to set a password with `passwd` post-install.
  users = {
    extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

    users = {
      noah = {
        isNormalUser = true;
        initialPassword = "temp";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
        shell = pkgs.zsh;
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Optimise store
  nix.settings.auto-optimise-store = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    # Internet
    pkgs.firefox

    # Multi-media
    pkgs.vlc

    # Tools
    pkgs.wget
    pkgs.curl
    pkgs.git
    
    pkgs.atuin
    pkgs.pfetch
    pkgs.starship

    pkgs.pinentry
    pkgs.gnome.dconf-editor

    # Gnome
    pkgs.gnome-menus # needed for arc menu extension
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
