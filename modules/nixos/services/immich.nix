{
  lib,
  config,
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
      mediaLocation = "/pool/dataset/immich";
      openFirewall = true;
      # host = "0.0.0.0";
      environment = {IMMICH_LOG_LEVEL = "verbose";};
    };
  };
}
