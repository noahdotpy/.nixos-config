{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.windowmanager.add-on.waybar;
  device = config.modules.device;
in {
  options.modules.windowmanager.add-on.waybar = {enable = mkEnableOption "waybar";};

  config = mkIf cfg.enable {
    home.manager.programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = forEach device.monitors (
        monitor:
          mapAttrs (n: v: v)
          {
            "output" = monitor;
            "layer" = "top";
            "position" = "top";
            "modules-left" = [
              "sway/workspaces"
              "sway/mode"
            ];

            "modules-center" = [
              "clock"
            ];

            "sway/workspaces" = {
              "format" = "{value}";
            };

            "sway/mode" = {
              "format" = " {}";
              "max-length" = 100;
            };

            "network#down" = {
              "format" = " {bandwidthDownBits}";
              "tooltip-format" = "{ifname} {ipaddr}";
              "interval" = 1;
            };

            "network#up" = {
              "format" = " {bandwidthUpBits}";
              "tooltip-format" = "{ifname} {ipaddr}";
              "interval" = 1;
            };

            "disk#home" = {
              "format" = " {used}";
              "interval" = 30;
              "path" = "/home/budiman";
            };

            "disk#root" = {
              "format" = " {used}";
              "interval" = 30;
              "path" = "/";
            };

            "custom/uname" = {
              "format" = " {}";
              "exec" = "${pkgs.coreutils-full}/bin/uname -r";
              "tooltip" = false;
            };

            "clock" = {
              "format" = "{: %a,%d%b  %I:%M%p}";
              "interval" = 1;
              "timezone" = "Asia/Jakarta";
              "tooltip" = false;
            };
          }
          // {
            "modules-right" =
              [
                "network#down"
                "network#up"
                "disk#home"
                "disk#root"
              ]
              ++ (
                if monitor == last device.monitors
                then [
                  "custom/uname"
                  "tray"
                ]
                else []
              );
          }
      );

      style = ''
        * {
            border: none;
            border-radius: 0;
            font-family: "UbuntuMono Nerd Font";
            font-size: 16px;
            font-weight: bold;
            padding-top: 1px;
        }

        button {
          min-height: 24px;
          min-width: 16px;
        }

        window#waybar {
            background-color: transparent;
            color: #C0CAF5;
            transition-property: background-color;
            transition-duration: .5s;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        #workspaces button {
            color: #C0CAF5;
            padding: 0 3px;
            border-radius: 5px;
        }

        #workspaces button.focused {
            color: #7AA2F7;
        }

        #workspaces button.urgent {
            color: #F7768E;
        }

        #mode {
            color: #C0CAF5;
            padding-left: 2px;
            box-shadow: inset 0 -1.5px;
        }

        #clock {
            color: #C0CAF5;
        }

        #network.down {
            color: #9ECE6A;
            padding-right: 8px;
        }

        #network.up {
            color: #7AA2F7;
            padding-right: 8px;
        }

        #disk.home {
            color: #E0AF68;
            padding-right: 8px;
        }

        #disk.root {
            color: #F7768E;
            padding-right: 8px;
        }

        #custom-uname {
            color: #BB9AF7;
            padding-right: 8px;
        }

        #custom-update {
            color: #C0CAF5;
            padding-right: 2px;
        }

        #custom-update.needsupdate {
            color: #F7768E;
            padding-right: 2px;
        }

        #tray {
            color: #C0CAF5;
            padding-right: 8px;
            font-weight: normal;
        }
      '';
    };
  };
}
