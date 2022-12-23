{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.associations;
  device = config.modules.device;

  browserMime = ["firefox.desktop"];
  editorMime = ["nvim"];

  browserBin = "firefox";
  editorBin = "nvim";
  terminalBin = "kitty";

  sessionVariables = {
    BROWSER = browserBin;
    EDITOR = editorBin;
    TERMINAL = terminalBin;
  };

  xdgAssociations = {
    "text/html" = browserMime;
    "x-scheme-handler/http" = browserMime;
    "x-scheme-handler/https" = browserMime;
    "x-scheme-handler/ftp" = browserMime;
    "x-scheme-handler/chrome" = ["com.github.Eloston.UngoogledChromium.desktop"];
    "x-scheme-handler/about" = browserMime;
    "x-scheme-handler/unknown" = browserMime;
    "application/x-extension-htm" = browserMime;
    "application/x-extension-html" = browserMime;
    "application/x-extension-shtml" = browserMime;
    "application/xhtml+xml" = browserMime;
    "application/x-extension-xhtml" = browserMime;
    "application/x-extension-xht" = browserMime;

    "text/*" = editorMime;
    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    #"text/calendar" = [ "thunderbird.desktop" ];
    "application/json" = browserMime;
    "application/pdf" = ["okularApplication_pdf.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    "x-scheme-handler/spotify" = ["com.spotify.Client.desktop"];
    "x-scheme-handler/discord" = ["com.discordapp.Discord.desktop"];
  };
in {
  options.modules.associations = {
    mime.enable = mkEnableOption "enable mime associations";
    sessionVariables.enable = mkEnableOption "enable session variables";
  };
  config = mkMerge [
    (mkIf cfg.mime.enable {
      home.manager.xdg.mimeApps = {
        enable = true;
        associations.added = xdgAssociations;
        defaultApplications = xdgAssociations;
      };
    })
    (mkIf cfg.sessionVariables.enable {
      home.manager.xsession.enable = true;
      home.manager.home.sessionVariables = sessionVariables;
      home.manager.systemd.user.sessionVariables = sessionVariables;
    })
  ];
}
