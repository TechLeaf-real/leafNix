{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["techleaf"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.users.techleaf.extraGroups = ["libvirtd"];
}
