{
  lib,
  inputs,
  pkgs,
  pyprland,
  ...
}: {
  config = {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd hyprland";
          user = "techleaf";
        };
      };
    };

    fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

    services.dbus.packages = [pkgs.gcr];

    environment.sessionVariables = {
      HYPRSHOT_DIR = "Pictures/Screenshots";
    };

    environment.systemPackages =
      (with pkgs; [
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
      ])
      ++ (with pyprland.packages.${pkgs.system}; [
        pyprland
      ]);
  };
}
