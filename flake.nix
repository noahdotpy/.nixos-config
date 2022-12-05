{
  description = "My NixOS configurations IaC";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    devshell.url = "github:numtide/devshell";
  };

  outputs = {self, ...} @ inputs: let
    myLib = import ./lib/default.nix {inherit self inputs;};
  in
    inputs.flake-parts.lib.mkFlake {inherit self;} {
      systems = ["x86_64-linux"];
      perSystem = {
        inputs',
        pkgs,
        ...
      }: {
        legacyPackages = import ./packages {inherit pkgs;};

        devShells.default = inputs'.devshell.legacyPackages.mkShell {
          packages = [
            pkgs.alejandra
            pkgs.git
            pkgs.nix
          ];
          name = "dots";
          # NIX_CONFIG = "experimental-features = nix-command flakes";
        };
        formatter = pkgs.alejandra;
      };

      flake.nixosConfigurations = {
        ideapad-s145 = myLib.mkNixosSystem "x86_64-linux" "ideapad-s145" "noah";
      };
    };
}
