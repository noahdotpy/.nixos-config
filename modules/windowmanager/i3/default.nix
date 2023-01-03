{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.windowmanager.i3;
  device = config.modules.device;
in {
  options.modules.windowmanager.i3 = {
    enable = mkEnableOption "i3";
    isDefault = mkEnableOption "set i3 as default display manager session";
  };

  config = mkMerge [
    (mkIf cfg.isDefault {
      services.xserver.displayManager.defaultSession = "none+i3";
    })
    (mkIf cfg.enable {
      modules.windowmanager.add-on.blueman-applet.enable = true;
      modules.windowmanager.add-on.dunst.enable = true;
      modules.windowmanager.add-on.nm-applet.enable = true;
      modules.windowmanager.add-on.rofi.enable = true;
      modules.windowmanager.add-on.picom.enable = true;
      modules.windowmanager.add-on.py3status.enable = true;
      modules.windowmanager.add-on.thunar.enable = true;
      modules.windowmanager.add-on.xdg.enable = true;

      modules.system.font.enable = true;
      modules.system.sound.enable = true;
      modules.system.video.enable = true;

      modules.terminal-emulator.kitty.enable = true;

      assertions = [
        {
          assertion = length device.monitors > 0;
          message = ''
            At least one monitor in the `config.modules.device.monitors` is
            needeed to use i3 module.
          '';
        }
      ];

      services.greenclip.enable = true;
      services.xserver = {
        enable = true;
        desktopManager = {
          xterm.enable = false;
          runXdgAutostartIfNone = true;
        };
        windowManager.i3 = {
          enable = true;
          package = pkgs.i3-gaps;
          extraPackages = with pkgs; [
            adw-gtk3
            feh
            pulsemixer
            playerctl
            i3blocks
            autotiling
            numlockx
            picom
            polkit_gnome
            rofi
            rofimoji
            scrot
            haskellPackages.greenclip
            (python3Packages.py3status.overrideAttrs (oldAttrs: {
              propagatedBuildInputs = with python3Packages; [pytz tzlocal] ++ oldAttrs.propagatedBuildInputs;
            }))
            xfce.xfce4-power-manager
          ];
        };
      };
      networking.networkmanager.enable = true;
      programs.dconf.enable = true;
      security.polkit.enable = true;

      home.manager = {
        gtk.theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
        };
        xsession.windowManager.i3 = {
          enable = true;
          package = pkgs.i3-gaps;
          config = let
            workspaceBinds = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "0" = "10";
            };

            keybindings = mkMerge [
              {
                keybindings = {
                  # media/volume
                  "XF86AudioRaiseVolume" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume +${builtins.toString volumeStep}";
                  "XF86AudioLowerVolume" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume -${builtins.toString volumeStep}";
                  "XF86AudioMute" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --toggle-mute";
                  "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                  "${mod}+Ctrl+space" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

                  # brightness
                  "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set ${builtins.toString brightnessStep}%+";
                  "${mod}+Ctrl+Shift+Up" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set ${builtins.toString brightnessStep}%+";
                  "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set ${builtins.toString brightnessStep}%-";
                  "${mod}+Ctrl+Shift+Down" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set ${builtins.toString brightnessStep}%-";

                  # lock screen
                  "${mod}+l" = "exec ${lockScript}";

                  # app shortcuts
                  "${mod}+Return" = "exec ${terminalOpen}";
                  "${mod}+b" = "exec $BROWSER";
                  "${mod}+e" = "exec ${terminalExec} $EDITOR";
                  "${mod}+f" = "exec ${fileManagerOpen}";
                  "${mod}+Escape" = "exec ${terminalExec} ${systemMonitorOpen}";
                  "${mod}+Shift+F1" = "exec ${terminalExec} ${pkgs.pulsemixer}/bin/pulsemixer";

                  # screenshot
                  "Print" = "exec ${screenshotMenu}";
                  "${mod}+Print" = "exec ${screenshotSelect}";
                  "${mod}+Shift+Print" = "exec ${screenshotActiveWindow}";
                  "${mod}+Ctrl+Print" = "exec ${screenshotFullscreen}";

                  # menus
                  "${mod}+a" = "exec ${launcherDesktopApps}";
                  "${mod}+w" = "exec ${launcherWindowSwitcher}";
                  "${mod}+d" = "exec ${launcherBinaries}";
                  "${mod}+v" = "exec ${clipboardManagerShow}";
                  "${mod}+Shift+Escape" = "exec ${powerMenu}";
                  "${mod}+period" = "exec ${emojiChooser}";

                  # close window
                  "${mod}+Shift+c" = "kill";
                  # change focus to ... window
                  "${mod}+Left" = "focus left";
                  "${mod}+Down" = "focus down";
                  "${mod}+Up" = "focus up";
                  "${mod}+Right" = "focus right";
                  # move window
                  "${mod}+Shift+Left" = "move left";
                  "${mod}+Shift+Down" = "move down";
                  "${mod}+Shift+Up" = "move up";
                  "${mod}+Shift+Right" = "move right";

                  "${mod}+Shift+f" = "fullscreen toggle";
                  "${mod}+Shift+space" = "floating toggle";

                  # split in vertical orientation
                  "${mod}+Shift+v" = "split h";
                  # split in horizontal orientation
                  "${mod}+Shift+h" = "split v";
                  # # reload the configuration file
                  "${mod}+Shift+Ctrl+r" = "reload";
                  # # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
                  "${mod}+Shift+r" = "restart";
                  # # change focus between tiling / floating windows
                  "${mod}+space" = "focus mode_toggle";
                };
              }
              {
                keybindings = workspacesSwitch;
              }
            ];

            workspacesSwitch = lib.attrsets.mapAttrs' (name: value: lib.attrsets.nameValuePair "${mod}+${name}" "workspace number ${value}") workspaceBinds;

            lockScript = "${pkgs.i3lock}/bin/i3lock";
            terminalOpen = "${pkgs.kitty}/bin/kitty";
            terminalExec = "${terminalOpen} -e";

            fileManagerOpen = "${pkgs.gnome.nautilus}/bin/nautilus";

            systemMonitorOpen = "${pkgs.htop}/bin/htop";

            screenshotMenu = "${pkgs.ksnip}/bin/ksnip";
            screenshotSelect = "${pkgs.ksnip}/bin/ksnip -r";
            screenshotActiveWindow = "${pkgs.ksnip}/bin/ksnip -a";
            screenshotFullscreen = "${pkgs.ksnip}/bin/ksnip -f";

            launcherDesktopApps = "${pkgs.rofi}/bin/rofi -modi 'drun' -show drun -show-icons";
            launcherWindowSwitcher = "${pkgs.rofi}/bin/rofi -modi 'window' -show window -show-icons";
            launcherBinaries = "${pkgs.rofi}/bin/rofi -modi 'combi' -show combi -show-icons";

            clipboardManagerShow = "${pkgs.rofi}/bin/rofi -modi 'clipboard:${pkgs.haskellPackages.greenclip}/bin/greenclip print' -show clipboard -run-command '{cmd}'";

            powerMenu = builtins.toString ../add-on/rofi/scripts/rofi-powermenu.sh;

            emojiChooser = "${pkgs.rofimoji}/bin/rofimoji";

            mod = "Mod4";

            volumeStep = 5;
            brightnessStep = 5;
          in {
            modifier = mod;
            keybindings = keybindings.keybindings;
            colors = {
              focused = {
                border = "#9AA5CE";
                background = "#364A82";
                text = "#C0CAF5";
                indicator = "#9AA5CE";
                childBorder = "#9AA5CE";
              };
              focusedInactive = {
                border = "#16161D";
                background = "#16161D";
                text = "#C0CAF5";
                indicator = "#16161D";
                childBorder = "#16161D";
              };
              unfocused = {
                border = "#16161D";
                background = "#16161D";
                text = "#C0CAF5";
                indicator = "#16161D";
                childBorder = "#16161D";
              };
              urgent = {
                border = "#EC69A0";
                background = "#DB3279";
                text = "#FFFFFF";
                indicator = "#DB3279";
                childBorder = "#DB3279";
              };
              placeholder = {
                border = "#000000";
                background = "#0C0C0C";
                text = "#FFFFFF";
                indicator = "#000000";
                childBorder = "#0C0C0C";
              };
            };
            bars = [
              {statusCommand = "SCRIPT_DIR=~/.config/i3blocks/scripts ${pkgs.i3blocks}/bin/i3blocks";}
            ];
            gaps = {
              inner = 6;
              outer = -2;
            };
            window.border = 2;
            floating.border = 2;
          };
        };
      };
    })
  ];
}
######################
##### TO MIGRATE #####
######################
# set $ws1 "1"
# set $ws2 "2"
# set $ws3 "3"
# set $ws4 "4"
# set $ws5 "5"
# set $ws6 "6"
# set $ws7 "7"
# set $ws8 "8"
# set $ws9 "9"
# set $ws10 "10"
#
#
# # toggle touchpad
# bindsym $mod+Ctrl+t exec ~/.scripts/github.com/noahdotpy/.dotfiles/toggle_touchpad.sh
# # keybinding to open rofi emoji menu
# bindsym $mod+period exec "${pkgs.rofi}/bin/rofi -modi emoji -show emoji"
#
# # change focus
# # bindsym $mod+h focus left
# # bindsym $mod+j focus down
# # bindsym $mod+k focus up
# # bindsym $mod+l focus right
#
# # move focused window
# # bindsym $mod+Shift+h move left
# # bindsym $mod+Shift+j move down
# # bindsym $mod+Shift+k move up
# # bindsym $mod+Shift+l move right
#
# # change container layout (stacked, tabbed, toggle split)
# bindsym $mod+Ctrl+s layout stacking
# bindsym $mod+Ctrl+w layout tabbed
# bindsym $mod+Ctrl+e layout toggle split
#
#
# # switch to workspace
# bindsym $mod+1 workspace number $ws1
# bindsym $mod+2 workspace number $ws2
# bindsym $mod+3 workspace number $ws3
# bindsym $mod+4 workspace number $ws4
# bindsym $mod+5 workspace number $ws5
# bindsym $mod+6 workspace number $ws6
# bindsym $mod+7 workspace number $ws7
# bindsym $mod+8 workspace number $ws8
# bindsym $mod+9 workspace number $ws9
# bindsym $mod+0 workspace number $ws10
#
# # move focused container to workspace
# bindsym $mod+Shift+1 move container to workspace number $ws1
# bindsym $mod+Shift+2 move container to workspace number $ws2
# bindsym $mod+Shift+3 move container to workspace number $ws3
# bindsym $mod+Shift+4 move container to workspace number $ws4
# bindsym $mod+Shift+5 move container to workspace number $ws5
# bindsym $mod+Shift+6 move container to workspace number $ws6
# bindsym $mod+Shift+7 move container to workspace number $ws7
# bindsym $mod+Shift+8 move container to workspace number $ws8
# bindsym $mod+Shift+9 move container to workspace number $ws9
# bindsym $mod+Shift+0 move container to workspace number $ws10
#
# # exit i3 (logs you out of your X session)
# # bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"
# # using plasma's logout screen instead of i3's
# # bindsym $mod+Shift+e exec --no-startup-id qdbus-qt5 org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout -1 -1 -1
# # resize window (you can also use the mouse for that)
# mode "resize" {
#         # These bindings trigger as soon as you enter the resize mode
#
#         # Pressing left will shrink the window’s width.
#         # Pressing right will grow the window’s width.
#         # Pressing up will shrink the window’s height.
#         # Pressing down will grow the window’s height.
#         bindsym h resize shrink width 5 px or 5 ppt
#         bindsym j resize grow height 5 px or 5 ppt
#         bindsym k resize shrink height 5 px or 5 ppt
#         bindsym l resize grow width 5 px or 5 ppt
#
#         # same bindings, but for the arrow keys
#         bindsym Left resize shrink width 5 px or 5 ppt
#         bindsym Down resize grow height 5 px or 5 ppt
#         bindsym Up resize shrink height 5 px or 5 ppt
#         bindsym Right resize grow width 5 px or 5 ppt
#
#         # back to normal: Enter or Escape or $mod+r
#         bindsym Return mode "default"
#         bindsym Escape mode "default"
#         bindsym $mod+r mode "default"
# }
# bindsym $mod+r mode "resize"
#
# ###################
# # => Eye candy: ###
# ###################
# # Font for window titles. Will also be used by the bar unless a different font
# # is used in the bar {} block below.
# # font pango:monospace 8
# # This font is widely installed, provides lots of unicode glyphs, right-to-left
# # text rendering and scalability on retina/hidpi displays (thanks to pango).
# font pango:DejaVu Sans Mono 8
#
# # force apps to have borders (mainly for GTK)
# for_window [class=.*] border pixel 2
#
# # restore feh wallpaper
# exec_always ~/.fehbg
#
# ########################
# # => Other settings: ###
# ########################
# # Start XDG autostart .desktop files using dex. See also
# # https://wiki.archlinux.org/index.php/XDG_Autostart
# # exec --no-startup-id dex-autostart --autostart --environment i3
#
# # The combination of xss-lock, nm-applet and pactl is a popular choice, so
# # they are included here as an example. Modify as you see fit.
#
# # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# # screen before suspend. Use loginctl lock-session to lock your screen.
# exec --no-startup-id xss-lock --transfer-sleep-lock -- ${lockExec}
#
# # auto-lock the screen after 3 minutes
# exec xautolock -detectsleep -time 15 -locker "${lockExec}"
#
# # autotiling for i3
# exec_always --no-startup-id ${pkgs.autotiling}/bin/autotiling
#
# # automatically float these windows
# for_window [class="ksnip"] floating enable

