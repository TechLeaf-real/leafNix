{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hyprland;
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    accent = "yellow";
    variant = "mocha";
  };
in {
  options = {
    hyprland = {
      primaryModifier = lib.mkOption {
        type = lib.types.str;
        default = "SUPER";
      };
      secondaryModifier = lib.mkOption {
        type = lib.types.str;
        default = "LEFT_ALT";
      };
      terminal = lib.mkOption {
        type = lib.types.str;
        default = "kitty";
      };
    };
  };

  config = {
    programs.kitty = lib.mkIf (cfg.terminal == "kitty") {
      enable = true;
    };

    home.packages = with pkgs; [
      (catppuccin-kvantum.override {
        accent = "yellow";
        variant = "mocha";
      })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      papirus-folders
      pamixer
      networkmanagerapplet
    ];

    services.blueman-applet.enable = true;

    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-yellow-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = ["yellow"];
          size = "standard";
          variant = "mocha";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "yellow";
        };
      };
      cursorTheme = {
        name = "Catppuccin-Mocha-Dark-Cursors";
        package = pkgs.catppuccin-cursors.mochaYellow;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaYellow;
      size = 16;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "catppuccin-mocha-yellow-standard";
        color-scheme = "prefer-dark";
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "catppuccin-mocha-yellow-standard";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "catppuccin-mocha-yellow";
      };
    };

    services.playerctld.enable = true;

    programs.wofi = {
      enable = true;
    };

    services.mako = {
      enable = true;
      settings = {
      };
    };

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = ["hyprland/workspaces" "hyprland/mode" "wlr/taskbar"];
          modules-center = ["custom/icon"];
          modules-right = ["tray" "wireplumber" "battery"];

          "hyprland/workspaces" = {
            format = " ";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };

          "custom/icon" = {
            format = "/";
          };

          "clock" = {
            format = "{: %I:%M %p   %d/%m/%Y}";
          };

          "bluetooth" = {
            format = "󰂯";
            format-connected = "󰂱";
            format-disabled = "󰂲";
            format-off = "󰂲";
            format-no-controller = "⚠";
            on-click = "blueman-manager";
          };

          "wireplumber" = {
            format = "{icon}";
            format-bluetooth = "󰂰 ";
            nospacing = 1;
            tooltip-format = "Volume : {volume}%";
            format-muted = "󰝟 ";
            format-icons = {
              headphone = " ";
              default = ["󰖀 " "󰕾 " " "];
            };
            on-click = "pamixer -t";
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
            format-wifi = "";
            format-ethernet = "";
            tooltip-format = "{essid} ({signalStrength}%)";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "⚠";
          };
        };
      };

      style = ''
        * {
          font-family: Symbols Nerd Font;
        }

        .module {
          border-radius: 10px;
          margin: 0 5px;
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

        #clock {
          padding: 0 10px;
        }

        #bluetooth {
          padding: 0 10px;
          background-color: #11111b;
          color: white;
        }

        #network {
          background-color: #11111b;
          color: white;
          padding: 0 8px;
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

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = ["~/Pictures/Wallpapers/catppuccin-wallpapers-main/os/nix-black-4k.png"];

        wallpaper = [
          ", ~/Pictures/Wallpapers/catppuccin-wallpapers-main/os/nix-black-4k.png"
        ];
      };
    };

    services.hyprpolkitagent.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [
          "eDP-1, 1920x1080@120, 0x0, 1"
        ];

        exec-once = [
          "mako"
          "waybar"
          "hyprpaper"
          "nm-applet"
        ];

        general = {
          "border_size" = 3;
          "col.active_border" = "rgba(f9e2afff)";
        };

        input = {
          kb_layout = "gb";
          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = true;
        };

        decoration = {
          rounding = 10;
          inactive_opacity = 0.8;
        };

        "$mod1" = cfg.primaryModifier;
        "$mod2" = cfg.secondaryModifier;
        bind = [
          "$mod1, T, exec, ${cfg.terminal}"
          "$mod2, M, exit"
          "$mod2, Q, killactive"
          "$mod1, P, fullscreen"
          "$mod1, GRAVE, exec, wofi --show drun"
          "$mod1, RIGHT, swapwindow, r"
          "$mod1, LEFT, swapwindow, l"
          "$mod1, UP, swapwindow, u"
          "$mod1, DOWN, swapwindow, d"
          "$mod1, F, togglefloating"
          "$mod1, L, pin"
          "$mod1 LEFT_CTRL, RIGHT, workspace, +1"
          "$mod1 LEFT_CTRL, LEFT, workspace, -1"
          "$mod1 LEFT_CTRL LEFT_SHIFT, RIGHT, movetoworkspace, +1"
          "$mod1 LEFT_CTRL LEFT_SHIFT, LEFT, movetoworkspace, -1"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioStop, exec, playerctl stop"
        ];
      };
    };
  };
}
