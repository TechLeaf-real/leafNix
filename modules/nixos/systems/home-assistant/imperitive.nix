{
  lib,
  config,
  ...
}: let
  cfg = config.home-assistant;
in {
  config =
    lib.mkIf (cfg.enable && cfg.imperitive.enable) {
    };
}
