{
  lib,
  config,
  pkgs,
  pkgs-stable,
  ...
}: let
  cfg = config.hyprland;
in {
  options = {
    hyprland = {
      enable = lib.mkEnableOption "hyprland";
      displayManager = {
        enable = lib.mkOption {
          default = true;
          example = false;
          description = "Whether to enable the display manager";
          type = lib.types.bool;
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };

    services.clipcat = {
      enable = true;
      package = pkgs-stable.clipcat;
    };

    services.greetd = lib.mkIf cfg.displayManager.enable {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'dbus-run-session Hyprland'";
          user = "techleaf";
        };
      };
    };

    fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

    services.dbus.packages = [pkgs.gcr];

    environment.sessionVariables = {
      HYPRSHOT_DIR = "Pictures/Screenshots";
      NIXOS_OZONE_WL = "1";
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    };

    environment.systemPackages = with pkgs; [
      rofi-bluetooth
      rofi-systemd
      rofi-power-menu
      rofi-network-manager
      rofi-obsidian
      rofi-rbw
      rofi-pulse-select
      wtype
      libqalculate
      hyprnome
      xdg-utils
    ];
  };
}
