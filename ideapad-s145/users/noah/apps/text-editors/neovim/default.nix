{
  programs.neovim = {
    enable = true;
    extraConfig = ''
    :luafile ${./config/init.lua}
    :luafile ${./config/lua/plugins/init.lua}
    :luafile ${./config/lua/settings/init.lua}
    :luafile ${./config/lua/mappings/init.lua}
    '';
  };
}
