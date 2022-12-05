{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal-emulator.kitty;
in {
  options.modules.terminal-emulator.kitty = {enable = mkEnableOption "kitty";};

  config = mkIf cfg.enable {
    home.manager.programs.kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      font = {
        name = "Iosevka Nerd Font";
        size = 12;
      };
      settings = {
        # Cursor
        cursor = "#C0CAF5";
        cursor_text_color = "#202124";
        cursor_shape = "underline";
        cursor_blink_interval = "-1";

        # Scrollback
        scrollback_lines = 10000;

        # Mouse
        mouse_hide_wait = "-1";
        url_color = "#73DACA";
        url_style = "curly";

        #Terminal bell
        enable_audio_bell = "no";
        visual_bell_duration = 0;

        # Window layout
        window_padding_width = 4;
        confirm_os_window_close = 0;

        # Advanced
        allow_remote_control = "no";
        shell_integration = "disabled";
        term = "xterm-256color";
      };
    };
  };
}
