{ inputs, lib, config, pkgs, pkgs-stable, ...}:

let
  cfg = config.hyprland;
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    accent = "yellow";
    variant = "mocha";
  };
in
{
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
      fileManager = lib.mkOption {
        type = lib.types.str;
        default = "nautilus";
      };
      appLauncher = lib.mkOption {
        type = lib.types.str;
        default = "rofi";
      };
    };
  };

  config = {
    programs.kitty = lib.mkIf (cfg.terminal == "kitty") {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      settings = {
        background_opacity = 0.75;
        background_blur = 16;
      };
    };

    programs.alacritty = lib.mkIf (cfg.terminal == "alacritty") {
      enable = true;
      settings = {
        colors.primary = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        dim_foreground = "#7f849c";
        bright_foreground = "#cdd6f4";
        };

        colors.cursor = {
        text = "#1e1e2e";
        cursor = "#f5e0dc";
        };

        colors.vi_mode_cursor = {
        text = "#1e1e2e";
        cursor = "#b4befe";
        };

        colors.search.matches = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
        };

        colors.search.focused_match = {
        foreground = "#1e1e2e";
        background = "#a6e3a1";
        };

        colors.footer_bar = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
        };

        colors.hints.start = {
        foreground = "#1e1e2e";
        background = "#f9e2af";
        };

        colors.hints.end = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
        };

        colors.selection = {
        text = "#1e1e2e";
        background = "#f5e0dc";
        };

        colors.normal = {
        black = "#45475a";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#bac2de";
        };

        colors.bright = {
        black = "#585b70";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#a6adc8";
        };

        colors.indexed_colors = [
          {
            index = 16;
            color = "#fab387";
          }
          {
            index = 17;
            color = "#f5e0dc";
          }
        ];
      };
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
      # networkmanagerapplet
      hyprshot
      cava
      swayosd
    ];

    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-yellow-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "yellow" ];
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

    home.sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = 0;
      QT_SCALE_FACTOR = 1;
    };

    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
        General.theme = "catppuccin-mocha-yellow";
      };
    };

    services.playerctld.enable = true;

    programs.wofi = lib.mkIf (cfg.appLauncher == "wofi") {
      enable = true;
    };

    programs.rbw = {
      enable = true;
      settings = {
        base_url = "https://pass.techleaf.dev";
        email = "mikiediggins@gmail.com";
        lock_timeout = 86400;
        pinentry = pkgs.pinentry-gnome3;
      };
    };

    programs.rofi = lib.mkIf (cfg.appLauncher == "rofi") {
      enable = true;
      package = pkgs.rofi-wayland.override { plugins = with pkgs; [
        rofi-calc
        rofi-games
        rofi-file-browser
      ]; };
      theme = "custom";
      extraConfig = {
        modi = "drun,games,calc,file-browser-extended,bluetooth:rofi-bluetooth,power:rofi-power-menu,network:rofi-network-manager";
        show-icons = true;
        drun-display-format = "{icon} {name}";
        disable-history = false;
        hide-scrollbar = true;
      };
    };

    home.file.".config/rofi/themes/custom.rasi".text = lib.mkIf (cfg.appLauncher == "rofi") ''
      * {
        rosewater: #f5e0dc;
        flamingo: #f2cdcd;
        pink: #f5c2e7;
        mauve: #cba6f7;
        red: #f38ba8;
        maroon: #eba0ac;
        peach: #fab387;
        yellow: #f9e2af;
        green: #a6e3a1;
        teal: #94e2d5;
        sky: #89dceb;
        sapphire: #74c7ec;
        blue: #89b4fa;
        lavender: #b4befe;
        text: #cdd6f4;
        subtext1: #bac2de;
        subtext0: #a6adc8;
        overlay2: #9399b2;
        overlay1: #7f849c;
        overlay0: #6c7086;
        surface2: #585b70;
        surface1: #45475a;
        surface0: #313244;
        base: #1e1e2e;
        mantle: #181825;
        crust: #11111b;
        selected-active-foreground:  @background;
        lightfg:                     @text;
        separatorcolor:              @foreground;
        urgent-foreground:           @red;
        alternate-urgent-background: @lightbg;
        lightbg:                     @mantle;
        background-color:            transparent;
        border-color:                @foreground;
        normal-background:           @background;
        selected-urgent-background:  @red;
        alternate-active-background: @lightbg;
        spacing:                     2;
        alternate-normal-foreground: @foreground;
        urgent-background:           @background;
        selected-normal-foreground:  @lightbg;
        active-foreground:           @blue;
        background:                  @base;
        selected-active-background:  @blue;
        active-background:           @background;
        selected-normal-background:  @lightfg;
        alternate-normal-background: @lightbg;
        foreground:                  @text;
        selected-urgent-foreground:  @background;
        normal-foreground:           @foreground;
        alternate-urgent-foreground: @red;
        alternate-active-foreground: @blue;
      }
      element {
          padding: 1px ;
          cursor:  pointer;
          spacing: 5px ;
          border:  0;
      }
      element normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      element normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      element normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      element selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      element selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      element selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      element alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      element alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      element alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      element-text {
          background-color: transparent;
          cursor:           inherit;
          highlight:        inherit;
          text-color:       inherit;
      }
      element-icon {
          background-color: transparent;
          size:             1.0000em ;
          cursor:           inherit;
          text-color:       inherit;
      }
      window {
          padding:          5;
          background-color: @background;
          border:           1;
      }
      mainbox {
          padding: 0;
          border:  0;
      }
      message {
          padding:      1px ;
          border-color: @separatorcolor;
          border:       2px dash 0px 0px ;
      }
      textbox {
          text-color: @foreground;
      }
      listview {
          padding:      2px 0px 0px ;
          scrollbar:    true;
          border-color: @separatorcolor;
          spacing:      2px ;
          fixed-height: 0;
          border:       2px dash 0px 0px ;
      }
      scrollbar {
          width:        4px ;
          padding:      0;
          handle-width: 8px ;
          border:       0;
          handle-color: @normal-foreground;
      }
      sidebar {
          border-color: @separatorcolor;
          border:       2px dash 0px 0px ;
      }
      button {
          cursor:     pointer;
          spacing:    0;
          text-color: @normal-foreground;
      }
      button selected {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      num-filtered-rows {
          expand:     false;
          text-color: Gray;
      }
      num-rows {
          expand:     false;
          text-color: Gray;
      }
      textbox-num-sep {
          expand:     false;
          str:        "/";
          text-color: Gray;
      }
      inputbar {
          padding:    1px ;
          spacing:    0px ;
          text-color: @normal-foreground;
          children:   [ "prompt","textbox-prompt-colon","entry","num-filtered-rows","textbox-num-sep","num-rows","case-indicator" ];
      }
      case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
      }
      entry {
          text-color:        @normal-foreground;
          cursor:            text;
          spacing:           0;
          placeholder-color: Gray;
          placeholder:       "Type to filter";
      }
      prompt {
          spacing:    0;
          text-color: @normal-foreground;
      }
      textbox-prompt-colon {
          margin:     0px 0.3000em 0.0000em 0.0000em ;
          expand:     false;
          str:        ":";
          text-color: inherit;
      }
    '';

    home.file.".config/rofi/themes/games-default.rasi".text = lib.mkIf (cfg.appLauncher == "rofi") ''
      // Colours
      * {
          background-color:               transparent;
          background:                     #1D2330;
          background-transparent:         #1D2330A0;
          text-color:                     #BBBBBB;
          text-color-selected:            #FFFFFF;
          primary:                        #BB77BB;
          important:                      #BF616A;
      }

      configuration {
          font:                           "Roboto 17";
          show-icons:                     true;
      }

      window {
          fullscreen:                     true;
          height:                         100%;
          width:                          100%;
          transparency:                   "real";
          background-color:               @background-transparent;
          border:                         0px 0px 0px 0px;
          border-color:                   @primary;
      }

      mainbox {
          children:                       [prompt, inputbar-box, listview];
          padding:                        0px 0px;
      }

      prompt {
          width:                          100%;
          margin:                         10px 0px 0px 30px;
          text-color:                     @important;
          font:                           "Roboto Bold 27";
      }

      listview {
          layout:                         vertical;
          padding:                        60px;
          dynamic:                        true;
          columns:                        7;
          spacing:                        20px;
      }

      inputbar-box {
          children:                       [dummy, inputbar, dummy];
          orientation:                    horizontal;
          expand:                         false;
      }

      inputbar {
          children:                       [textbox-prompt, entry];
          margin:                         0px;
          background-color:               @primary;
          border:                         4px;
          border-color:                   @primary;
          border-radius:                  8px;
      }

      textbox-prompt {
          text-color:                     @background;
          horizontal-align:               0.5;
          vertical-align:                 0.5;
          expand:                         false;
      }

      entry {
          expand:                         false;
          padding:                        8px;
          margin:                         -6px;
          horizontal-align:               0;
          width:                          300;
          background-color:               @background;
          border:                         6px;
          border-color:                   @primary;
          border-radius:                  8px;
          cursor:                         text;
      }

      element {
          children:                       [dummy, element-box, dummy];
          padding:                        5px;
          orientation:                    vertical;
          border:                         0px 4px solid 0px 4px;
          border-color:                   transparent;
          border-radius:                  16;
      }

      element selected {
          border-color:                   @primary;
      }

      element-box {
          children:                       [element-icon, element-text];
          orientation:                    vertical;
          expand:                         false;
          cursor:                         pointer;
      }

      element-icon {
          padding:                        10px;
          cursor:                         inherit;
          size:                           33%;
          margin:                         10px;
      }

      element-text {
          horizontal-align:               0.5;
          cursor:                         inherit;
          text-color: @text-color;
      }

      element-text selected {
          text-color: @text-color-selected;
      }

    '';

    home.file.".config/rofi/themes/games-smaller.rasi".text = lib.mkIf (cfg.appLauncher == "rofi") ''
      @import "games-default"

      window {
          fullscreen:                     false;
          border-radius:                  10px;
          height:                         50%;
          width:                          50%;
      }

      listview {
          columns:                        5;
          padding:                        30px;
      }

      prompt {
          enabled:                        false;
      }

      inputbar {
          margin:                         20px 0px 10px 0px;
      }

      element-icon {
          padding:                        0px 10px;
          size:                           12%;
      }
    '';

    home.file.".config/rofi-games/config.toml".text = lib.mkIf (cfg.appLauncher == "rofi") ''

    '';

    services.mako = {
      enable = true;
      settings = {
        background-color = "#1e1e2e";
        text-color = "#cdd6f4";
        border-color = "#f9e2af";
        progress-color = "#313244";
        border-radius = 10;
        default-timeout = 10;
      };
      extraConfig = ''
        [urgency=high]
        border-color=#fab387
      '';
    };

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

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = [ "~/Pictures/Wallpapers/catppuccin-wallpapers-main/os/nix-black-4k.png" ];

        wallpaper = [
          ", ~/Pictures/Wallpapers/catppuccin-wallpapers-main/os/nix-black-4k.png"
        ];
      };
    };

    services.hyprpolkitagent.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = with inputs; [
        hyprland-plugins.packages.${pkgs.system}.hyprexpo
        hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
      ];
      settings = {
        monitor = [
	        "DP-1, 1920x1080@100, 0x0, 1"
          "DP-2, 1920x1080@100, 1920x0, 1"
          "DP-3, 1920x1080@144, 1920x1080, 1"
          "HDMI-A-1, 1920x1080@75, 0x1080, 1"
        ];

        exec-once = [
          "mako"
          "waybar"
          "hyprpaper"
          "nm-applet"
          "pypr"
          "swayosd-server"
        ];

        plugin = {
          dynamic-cursors = {
            enabled = true;
            mode = "rotate";
            threshold = 2;
            rotate = {
              length = 20;
              offset = 0.0;
            };
            shake = {
              enabled = false;
            };
          };
          hyprexpo = {
            columns = 3;
            gap_size = 5;
            bg_col = "rgb(111111)";
            workspace_method = "center current";
          };
        };

        animations = {
          bezier = [
            "easeOutQuint, 0.23, 1, 0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear, 0, 0, 1, 1"
            "almostLinear, 0.5, 0.5, 0.75, 1.0"
            "quick, 0.15, 0, 0.1, 1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        general = {
          "border_size" = 3;
          "col.active_border" = "rgba(f9e2afff)";
        };

        input = {
          kb_layout = "us";
          touchpad = {
            natural_scroll = true;
          };
          accel_profile = "flat";
        };

        decoration = {
          rounding = 10;
          border_part_of_window = false;
        };

        "$mod1" = cfg.primaryModifier;
        "$mod2" = cfg.secondaryModifier;
        bind = [
          "$mod1, T, exec, ${cfg.terminal}"
          "$mod1, E, exec, ${cfg.fileManager}"
          "$mod2, Q, killactive"
          "$mod1, P, fullscreen"
          "$mod1 SHIFT, S, exec, hyprshot -m region"
          "$mod1, S, exec, hyprshot -m window"
          "$mod1, Z, hyprexpo:expo, toggle"
          "$mod1, GRAVE, exec, rofi -show drun"
          "$mod1, HOME, exec, rofi-rbw"
          "$mod1, RIGHT, swapwindow, r"
          "$mod1, LEFT, swapwindow, l"
          "$mod1, UP, swapwindow, u"
          "$mod1, DOWN, swapwindow, d"
          "$mod1, F, togglefloating"
          "$mod1, L, pin"
          "$mod1 LEFT_CTRL, RIGHT, exec, hyprnome"
          "$mod1 LEFT_CTRL, LEFT, exec, hyprnome --previous"
          "$mod1 LEFT_CTRL LEFT_SHIFT, RIGHT, exec, hyprnome --move"
          "$mod1 LEFT_CTRL LEFT_SHIFT, LEFT, exec, hyprnome --previous --move"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioStop, exec, playerctl stop"
          ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ];
        
        bindm = [
          "$mod1, mouse:272, movewindow"
        ];

        binde = [
          ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume 1"
        ];

        bindl = [
          ", XF86AudioLowerVolume, exec, swayosd-client --output-volume -1"
        ];
      };
    };
  };
}
