{pkgs, ...}: {
  vimPlugins = pkgs.callPackage ./vimPlugins/default.nix {};
}
