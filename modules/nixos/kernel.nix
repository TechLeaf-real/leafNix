{ lib, config, pkgs, ...}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = [
    #   "quiet"
    #   "vt.global_cursor_default=0"
    # ];
  };
}