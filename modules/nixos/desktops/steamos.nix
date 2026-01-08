{
  lib,
  config,
  ...
}: let
  cfg = config.steamos;
in {
  options = {
    steamos = {
      enable = lib.mkEnableOption "steamos";
    };
  };

  config = lib.mkIf cfg.enable {
    jovian.steam = {
      enable = true;
    };
  };
}
