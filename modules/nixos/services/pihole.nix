{
  config,
  lib,
  ...
}: let
  cfg = config.pihole;
in {
  options = {
    pihole = {
      enable = lib.mkEnableOption "pihole";
    };
  };

  config = lib.mkIf cfg.enable {
    services.pihole-ftl = {
      enable = true;
      openFirewallWebserver = true;
      openFirewallDNS = true;
    };
  };
}
