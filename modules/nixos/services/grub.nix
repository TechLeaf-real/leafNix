{
  config,
  lib,
  ...
}: let
  cfg = config.vscodium;
in {
  options = {
    grub = {
      enable = lib.mkEnableOption "grub";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = false;
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
