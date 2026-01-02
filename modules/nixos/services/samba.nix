{
  lib,
  config,
  ...
}: let
  cfg = config.samba;
in {
  options = {
    samba = {
      enable = lib.mkEnableOption "samba";
    };
  };

  config = lib.mkIf cfg.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "leaf-server";
          "netbios name" = "leaf-server";
          "security" = "user";
          "hosts allow" = "192.168.1. 127.0.0.1, localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "store" = {
          "path" = "/pool/dataset";
          "writeable" = "yes";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "techleaf";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
