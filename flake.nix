{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

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

    lib = nixpkgs.lib;
    
  in {
    
    nixosConfigurations = {
      ideapad-s145 = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        
        modules = [
          # Make the overlays available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-stable ]; })
          home-manager.nixosModules.home-manager # Allow home-manager as a NixOS module in flakes
          ./ideapad-s145/configuration.nix
        ];
      };
    };

  };
}
