{
  lib,
  config,
  ...
}: let
  cfg = config.network;
in {
  options = {
    network = {
      enable = lib.mkEnableOption "network";
      hostname = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      firewall.allowedTCPPorts = [1234 27017];
      hostName = cfg.hostname;
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
      networkmanager = {
        enable = true;
        dns = "none";
        wifi = {
          backend = "iwd";
        };
      };
      useDHCP = false;
    };
  };
}
