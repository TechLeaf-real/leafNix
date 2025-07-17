{ lib, pkgs, ...}:

{
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 44;
          modules-left = [ "custom/power" "clock" ];
          modules-center = [ "custom/icon" ];
          modules-right = [ "tray" "custom/bitwarden" "bluetooth" "network" "wireplumber"];

          "custom/bitwarden" = {
            format = "";
            on-click = "rofi-rbw";
          };

          "custom/icon" = {
            format = "/";
          };

          "clock" = {
            interval = 1;
            format = "{:%I:%M:%S %p}";
          };

          "custom/power" = {
            format = "󰐥";
            on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          };

          "bluetooth" = {
            format = "󰂯";
            format-connected = "󰂱 {device_alias}";
            format-disabled = "󰂲";
            format-off = "󰂲";
            format-no-controller = "⚠";
            on-click = "rofi-bluetooth";
          };

          "wireplumber" = {
            format = "{icon} {volume}%";
            nospacing = 1;
            tooltip-format = "Volume : {volume}%";
            format-muted = "󰝟";
            format-icons = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            on-click = "rofi-pulse-select sink";
            on-click-right = "rofi-pulse-select source";
            scroll-step = 1;
          };

          "battery" = {
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{icon}  {capacity}%";
            format-icons = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            format-charging = "󰂄 {capacity}%";
          };

          "tray" = {
            icon-size = 18;
            spacing = 10;
          };

          "network" = {
            format-disconnected = "";
            format-ethernet = "󰈀 {ipaddr}";
            tooltip = false;
            format = "{icon} {ipaddr}";
            format-icons = [
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            on-click = "rofi-network-manager";
          };
        };
      };

      style = ''
        * {
          font-family: JetBrainsMono Nerd Font Propo;
          transition: 250ms;
        }

        .module {
          border-radius: 10px;
          margin: 5px 5px;
        }

        #hyprland-workspaces {
          padding: 0 10px;
          background-color: #11111b;
          color: white;
        }

        #custom-icon {
          padding: 0 10px;
          font-size: 25px;
          background-color: transparent;
          color: #f9e2af;
        }

        #custom-power {
          padding: 0 10px;
          background-color: transparent;
          color: #f9e2af;
          background-color: #11111b;
        }

        #custom-power:hover {
          background-color: #f9e2af;
          color: #11111b;
        }

        #tray {
          padding: 0 10px;
          background-color: #11111b;
          color: white;
        }

        #wireplumber {
          padding: 0 10px;
          background-color: #11111b;
          color: white;
        }

        #wireplumber.muted {
          background-color: #f38ba8;
          color: black;
        }

        #clock {
          padding: 0 10px;
          background-color: #11111b;
          color: white;
        }

        #custom-bitwarden {
          padding: 0 10px;
          background-color: #11111b;
          color: white;
        }

        #bluetooth {
          padding: 0 10px;
          background-color: #11111b;
          color: white;
        }

        #bluetooth.connected {
          background-color: #f9e2af;
          color: black;
        }

        #network {
          background-color: #11111b;
          color: white;
          padding: 0 8px;
        }

        #network.ethernet {
          background-color: #f9e2af;
          color: black;
        }

        #battery {
          background-color: #11111b;
          color: white;
          padding: 0 10px;
        }

        #battery.charging {
          color: white;
          background-color: #a6e3a1;
        }

      '';
    };
}