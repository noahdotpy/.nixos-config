{inputs, ...}: {
  flake.homeConfigurations = {
    noah = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home/configurations/noah];

      # Optionally use extraSpecialArgs
      # to pass through arguments to the modules (i.e: home.nix).
    };
  };
}
