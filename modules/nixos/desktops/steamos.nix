{
  lib,
  config,
  ...
}: let
  cfg = config.steamos;
in {
  options = {
    steamos = {
      enable = lib.mkEnableOption "steamos";
      autoBoot = lib.mkEnableOption "steamos auto boot";
    };
  };

  config = lib.mkIf cfg.enable {
    jovian = {
      steam = {
        enable = true;
        desktopSession = "hyprland-uwsm";
        autoStart = cfg.autoBoot;
        user = "techleaf";
      };
      steamos = {
        useSteamOSConfig = false;
      };
    };
  };
}
