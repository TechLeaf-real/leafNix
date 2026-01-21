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
    services = {
    };
  };
}
