{
  config,
  lib,
  ...
}: let
  cfg = config.syncthing-client;
in {
  options = {
    syncthing-client = {
      enable = lib.mkEnableOption "syncthing-client";
    };
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      openDefaultPorts = true;
    };
  };
}
