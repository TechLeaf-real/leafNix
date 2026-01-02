{
  config,
  lib,
  ...
}: let
  cfg = config.virtualisation;
in {
  options = {
    virtualisation = {
      enable = lib.mkEnableOption "virtualisation";
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
