{
  lib,
  config,
  ...
}: let
  cfg = config.network;
in {
  options = {
    network = {
      hostname = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
      };
    };
  };

  config = {
    networking = {
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
