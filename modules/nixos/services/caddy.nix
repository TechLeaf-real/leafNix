{
  lib,
  config,
  ...
}: let
  cfg = config.caddy;
in {
  options = {
    caddy = {
      enable = lib.mkEnableOption "caddy";
    };
  };

  config = lib.mkIf cfg.enable {
    services.caddy = {
      enable = true;
      virtualHosts = {
        "techleaf.dev" = {
        };
      };
    };
  };
}
