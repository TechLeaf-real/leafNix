{ lib, config, pkgs, ...}:

{
  config = {
    fileSystems."~/leaf-server" = {
      device = "//192.168.1.115/store";
      fsType = "cifs";
      options = [ "username=techleaf" ];
    };
  };
}