{
  lib,
  config,
  # pkgs-stable,
  ...
}: let
  cfg = config.immich;
in {
  options = {
    immich = {
      enable = lib.mkEnableOption "immich";
    };
  };

  config = lib.mkIf cfg.enable {
    services.immich = {
      enable = true;
      # package = pkgs-stable.immich;
      mediaLocation = "/pool/dataset/immich";
      openFirewall = true;
      environment = {IMMICH_LOG_LEVEL = "verbose";};
      machine-learning.enable = false;
      accelerationDevices = null;
    };
  };
}
