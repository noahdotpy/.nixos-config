{ inputs, ... }:
{
  flake.nixosConfigurations = {
    ideapad-s145 = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      
      modules = [
        # Make the overlays available
        # ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-stable ]; })
        ./ideapad-s145
      ];
    };
  };
}
