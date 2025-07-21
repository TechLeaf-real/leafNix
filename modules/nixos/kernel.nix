{
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    # kernelParams = [
    #   "quiet"
    #   "vt.global_cursor_default=0"
    # ];
  };
}
