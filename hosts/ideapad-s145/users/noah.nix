{pkgs, ...}: {
  users.users = {
    noah = {
      isNormalUser = true;
      initialPassword = "temp";
      extraGroups = ["networkmanager" "wheel" "libvirtd"];
      shell = pkgs.zsh;
    };
  };
}
