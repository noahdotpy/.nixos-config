{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.windowmanager.add-on.dunst;
in {
  options.modules.windowmanager.add-on.dunst = {enable = mkEnableOption "dunst";};

  config = mkIf cfg.enable {
    home.manager = {
      home.packages = [pkgs.libnotify];
      services.dunst = {
        enable = true;
        settings = {
          global = {
            ### Display ###
            monitor = 0;
            follow = "none";

            ### Geometry ###
            width = 300;
            # The maximum height of a single notification, excluding the frame.
            height = 300;
            # Position the notification in the top right corner
            origin = "top-right";
            # Offset from the origin
            offset = "12x46";
            # Scale factor. It is auto-detected if value is 0.
            scale = 0;

            # Maximum number of notification (0 means no limit)
            notification_limit = 0;
            # Show how many messages are currently hidden (because of notification_limit).
            indicate_hidden = true;

            ### Progress bar ###
            # Turn on the progess bar. It appears when a progress hint is passed with
            # for example dunstify -h int:value:12
            progress_bar = true;
            # Set the progress bar height. This includes the frame, so make sure
            # it's at least twice as big as the frame width.
            progress_bar_height = 10;
            # Set the frame width of the progress bar
            progress_bar_frame_width = 1;
            # Set the minimum width for the progress bar
            progress_bar_min_width = 150;
            # Set the maximum width for the progress bar
            progress_bar_max_width = 300;

            # The transparency of the window.  Range: [0..=100].
            transparency = 0;

            # Draw a line of "separator_height" pixel height between two notifications.
            separator_height = 5;
            # Padding between text and separator.
            padding = 8;
            # Horizontal padding.
            horizontal_padding = 8;
            # Padding between text and icon.
            text_icon_padding = 0;
            # Defines width in pixels of frame around the notification window.
            # Set to 0 to disable.
            frame_width = 1;
            # Size of gap to display between notifications - requires a compositor.
            # If value is greater than 0, separator_height will be ignored and a border
            # of size frame_width will be drawn around each notification instead.
            gap_size = 4;

            # Sort messages by urgency.
            sort = true;

            # Don't remove messages, if the user is idle (no mouse or keyboard input)
            # for longer than idle_threshold seconds.
            # Set to 0 to disable.
            # A client can set the 'transient' hint to bypass this. See the rules
            # section for how to disable this if necessary
            # idle_threshold = 120

            ### Text ###

            font = "Iosevka Nerd Font 8";

            # The spacing between lines.  If the height is smaller than the
            # font height, it will get raised to the font height.
            line_height = 0;

            # Allow a small subset of html markup in notifications:
            # <b>bold</b> <i>italic</i> <s>strikethrough</s> <u>underline</u>
            markup = "full";

            # Alignment of message text.
            alignment = "center";

            # Vertical alignment of message text and icon.
            vertical_alignment = "center";

            # Show age of message if message is older than show_age_threshold seconds.
            # Set to -1 to disable.
            show_age_threshold = 60;

            # Specify where to make an ellipsis in long lines.
            # Possible values are "start", "middle" and "end".
            ellipsize = "middle";

            # Ignore newlines '\n' in notifications.
            ignore_newline = false;

            # Stack together notifications with the same content
            stack_duplicates = true;

            # Hide the count of stacked notifications with the same content
            hide_duplicate_count = false;

            # Display indicators for URLs (U) and actions (A).
            show_indicators = true;

            ### Icons ###

            # Recursive icon lookup. You can set a single theme, instead of having to
            # define all lookup paths.
            enable_recursive_icon_lookup = true;

            # Set icon theme (only used for recursive icon lookup)
            # You can also set multiple icon themes, with the leftmost one being used first.
            icon_theme = "Adwaita";

            # Align icons left/right/top/off
            icon_position = "left";
            # Scale small icons up to this size
            min_icon_size = 32;
            # Scale larger icons down to this size
            max_icon_size = 128;

            ### History ###

            # Should a notification popped up from history be sticky or timeout
            # as if it would normally do.
            sticky_history = true;

            # Maximum amount of notifications kept in history
            history_length = 20;

            ### Misc/Advanced ###
            # Browser for opening urls in context menu.
            browser = "xdg-open";
            # Always run rule-defined scripts, even if the notification is suppressed
            always_run_script = true;
            # Define the title of the windows spawned by dunst
            title = "Dunst";
            # Define the class of the windows spawned by dunst
            class = "Dunst";
            # Define the corner radius of the notification window
            corner_radius = 0;

            # Ignore the dbus closeNotification message.
            # Useful to enforce the timeout set by dunst configuration. Without this parameter, an application may close the notification sent before the user defined timeout.
            ignore_dbusclose = false;

            ### Wayland ###
            force_xwayland = false;

            ### Legacy

            # Use the Xinerama extension instead of RandR for multi-monitor support.
            # This setting is provided for compatibility with older nVidia drivers that
            # do not support RandR and using it on systems that support RandR is highly
            # discouraged.
            #
            # By enabling this setting dunst will not be able to detect when a monitor
            # is connected or disconnected which might break follow mode if the screen
            # layout changes.
            force_xinerama = false;

            ### mouse

            # Defines list of actions for each mouse event
            # These values can be strung together for each mouse event, and
            # will be executed in sequence.
            mouse_left_click = "close_current";
            mouse_middle_click = "do_action, close_current";
            mouse_right_click = "close_all";
            # Catppuccin Mocha
            };
            global = {
              frame_color = "#89B4FA";
              separator_color = "frame";
            };

            urgency_low = {
              background = "#1E1E2E";
              foreground = "#CDD6F4";
            };

            urgency_normal = {
              background = "#1E1E2E";
              foreground = "#CDD6F4";
            };

            urgency_critical = {
              background = "#1E1E2E";
              foreground = "#CDD6F4";
              frame_color = "#FAB387";
          };
        };
      };
    };
  };
}
