{
  description = "my nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nurpkgs.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {...} @ inputs: let
    system = "x86_64-linux";

    common-pkgs-config = {allowUnfree = true;};

    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {inherit common-pkgs-config;};
    };

    overlay-unstable = final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        inherit pkgs;
        config = {inherit common-pkgs-config;};
      };
    };

    overlay-stable = final: prev: {
      stable = import inputs.nixpkgs-stable {
        inherit system;
        config = {inherit common-pkgs-config;};
      };
    };
  in
    inputs.flake-parts.lib.mkFlake {inherit (inputs) self;} {
      imports = [
        ./nixos/configurations
        # ./home/configurations
      ];
      systems = ["x86_64-linux"];

      flake = {
        # # Devshell for bootstrapping
        # # Accessible through 'nix develop' or 'nix-shell' (legacy)
        devShell.x86_64-linux = pkgs.mkShell {
          # Enable experimental features without having to specify the argument
          NIX_CONFIG = "experimental-features = nix-command flakes";
          nativeBuildInputs = with pkgs; [nix home-manager git alejandra];
        };
        # TODO: Eventually migrate this into ./home/configurations/default.nix, with
        # overlay-stable and overlay-unstable available in both NixOS config and Home Manager config
        # flake.homeConfigurations = {
        homeConfigurations = {
          noah = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [./home/configurations/noah];

            # Optionally use extraSpecialArgs
            # to pass through arguments to the modules (i.e: home.nix).
          };
        };
      };
    };
}
