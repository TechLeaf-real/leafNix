{
  lib,
  config,
  ...
}: let
  cfg = config.vaultwarden;
in {
  options = {
    vaultwarden = {
      enable = lib.mkEnableOption "vaultwarden";
    };
  };

  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://pass.techleaf.dev";
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
    };
    networking.firewall.allowedTCPPorts = [8222];
  };
}
