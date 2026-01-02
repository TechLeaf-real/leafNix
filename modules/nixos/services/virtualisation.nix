{
  config,
  lib,
  ...
}: let
  cfg = config.virtualisation-config;
in {
  options = {
    virtualisation-config = {
      enable = lib.mkEnableOption "virtualisation-config";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["techleaf"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.users.techleaf.extraGroups = ["libvirtd"];
  };
}
