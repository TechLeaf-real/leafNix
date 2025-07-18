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

  imports = [
    ../rofi.nix
    ../kitty.nix
    ../waybar.nix
    # ../eww.nix
  ];

  config = {

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

    home.sessionVariables = {
    };

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

    programs.rbw = {
      enable = true;
      settings = {
        base_url = "https://pass.techleaf.dev";
        email = "mikiediggins@gmail.com";
        lock_timeout = 86400;
        pinentry = pkgs.pinentry-gnome3;
      };
    };

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
