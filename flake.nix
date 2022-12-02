{
  description = "my nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11"; 
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11"; 
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; 

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nurpkgs.url = "github:nix-community/NUR";
  };

  outputs =  inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    nurpkgs,
    ... }:
  let
    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };
    };

    overlay-stable = final: prev: {
      stable = import nixpkgs-stable {
        inherit system;
        config = { allowUnfree = true; };
      };
    };
  in {
    
    nixosConfigurations = {
      ideapad-s145 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        
        modules = [
          # Make the overlays available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-stable ]; })
          home-manager.nixosModules.home-manager # Allow home-manager as a NixOS module in flakes
          ./nixos/configurations/ideapad-s145
        ];
      };
    };

    homeConfigurations = {
      noah = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home/configurations/noah ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };

    # Devshell for bootstrapping
    # Accessible through 'nix develop' or 'nix-shell' (legacy)
    devShell.x86_64-linux = pkgs.mkShell {
      # Enable experimental features without having to specify the argument
      NIX_CONFIG = "experimental-features = nix-command flakes";
      nativeBuildInputs = with pkgs; [ nix home-manager git ];
    };
  };
}
