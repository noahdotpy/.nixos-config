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
      timeout = 1;
    };
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
      
      # Enable the KDE Plasma Desktop Environment.
      displayManager = {
        # sddm.enable = true;
        gdm.enable = true;
        defaultSession = "none+bspwm";
      };
      desktopManager = {
        plasma5.enable = true;
        gnome.enable = true;
      };

      # Enable all the (nerdy) window managers.
      windowManager = {
        # Dynamic tiling
        qtile = { enable = true; };
        leftwm = { enable = true; };
        # Manual tiling
        bspwm = { enable = true; };
        # Floating
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

    nm-applet.enable = true;

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

    kdeconnect.enable = true;

    fish.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
      };
    };
    starship.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
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
    pkgs.librewolf
    pkgs.wget
    pkgs.curl

    # Multi-media
    pkgs.vlc
    pkgs.pulseaudio
    
    # Text Editors
    pkgs.micro
    pkgs.vim
    # pkgs.neovim
    pkgs.notepadqq
    
    # CLI/TUI
    pkgs.htop
    pkgs.duplicity  
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.pulsemixer
    pkgs.acpi
    pkgs.git
    pkgs.feh
    pkgs.gnupg
    pkgs.gdu
    pkgs.ripgrep
    pkgs.ranger
    pkgs.pfetch

    # Tools
    pkgs.ark
    pkgs.ksnip
    pkgs.unzip
    pkgs.zip
    pkgs.pinentry
    pkgs.gnome.dconf-editor
    pkgs.bitwarden # awesome password manager

    # STANDALONE WINDOW MANAGER PROGRAMS
    # apps
    pkgs.gnome.nautilus
    # bars
    pkgs.eww
    pkgs.polybar
    # rofi
    pkgs.rofi
    pkgs.rofi-emoji
    # compositors
    pkgs.picom
    # tools
    pkgs.haskellPackages.greenclip
    pkgs.sxhkd # hotkey daemon
    pkgs.nitrogen
    # notifications
    pkgs.dunst
    # lock
    pkgs.i3lock-color
    pkgs.xlockmore
    
    # Libraries/Programming Languages
    pkgs.libsForQt5.kdialog
    pkgs.libsForQt5.kgpg
    pkgs.libnotify
    pkgs.gcc
    pkgs.glibc
    pkgs.python311
    pkgs.cargo
    pkgs.rustc
    pkgs.clippy
    pkgs.rustfmt

    # LSP
    pkgs.rnix-lsp # Nix
    pkgs.sumneko-lua-language-server # Lua
    pkgs.nodePackages.pyright # Python
    # pkgs.nodePackages_latest.typescript-language-server # Typescript

    # GNOME Extensions
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.pop-shell

    # Miscellaneous
    pkgs.onlyoffice-bin
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
