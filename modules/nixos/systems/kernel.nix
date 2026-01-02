{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.kernel;
in {
  options = {
    kernel = {
      enable = lib.mkEnableOption "kernel";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      kernelParams = [
        "quiet"
        "vt.global_cursor_default=0"
      ];
    };
  };
}
