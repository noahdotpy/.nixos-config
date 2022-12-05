{pkgs, ...}: {
  nvim-plugins = pkgs.callPackage ./nvim-plugins/default.nix {};
}
