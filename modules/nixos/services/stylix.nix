{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.stylix-config;
in {
  options = {
    stylix-config = {
      enable = lib.mkEnableOption "stylix-config";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";
      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };

    home-manager.sharedModules = lib.singleton {
      stylix = {
        targets = {
          bat.enable = false;
          zed.enable = false;
        };
      };
    };
  };
}
