{ lib, config, pkgs, ... }:

{ 
  options = {
    syncthing = {
      blender = lib.mkEnableOption "blender";
      code = lib.mkEnableOption "code";
      dcim = lib.mkEnableOption "dcim";
      emulation = lib.mkEnableOption "emulation";
      ssh = lib.mkEnableOption "ssh";
      obsidian = lib.mkEnableOption "obsidian";
      pictures = lib.mkEnableOption "pictures";
      roms = lib.mkEnableOption "roms";
      soundboard = lib.mkEnableOption "soundboard";
      videos = lib.mkEnableOption "videos";
    };
  };

  config = {
    services.syncthing = {
      enable = true;
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = { 
          leaf-server = {
            id = "O23FQNU-BNPEFVK-D7BEAAC-DRKV2D3-XF62HMQ-HTXDH4A-4EFJH72-HQYO4Q7";
            address = "tcp://192.168.1.115:22000";
          };
        };
        folders = {
          "Blender" = lib.mkIf config.syncthing.blender {
            path = "~/Blender";
            devices = [ "leaf-server" ];
            id = "lg5rx-zx62v";
          };
          "Code" = lib.mkIf config.syncthing.code {
            path = "~/Code";
            devices = [ "leaf-server" ];
            id = "wjun3-prxf2";
          };
          "DCIM" = lib.mkIf config.syncthing.dcim {
            path = "~/DCIM";
            devices = [ "leaf-server" ];
            id = "nookf-u7zge";
          };
          "Emulation" = lib.mkIf config.syncthing.emulation {
            path = "~/Emulation";
            devices = [ "leaf-server" ];
            id = "aqxvs-teezq";
          };
          "ssh" = lib.mkIf config.syncthing.ssh {
            path = "~/.ssh";
            devices = [ "leaf-server" ];
            id = "ssh";
          };
          "Obsidian" = lib.mkIf config.syncthing.obsidian {
            path = "~/Obsidian";
            devices = [ "leaf-server" ];
            id = "vsujy-eplhq";
          };
          "Pictures" = lib.mkIf config.syncthing.pictures {
            path = "~/Pictures";
            devices = [ "leaf-server" ];
            id = "al5vz-yucjc";
          };
          "Roms" = lib.mkIf config.syncthing.roms {
            path = "~/Roms";
            devices = [ "leaf-server" ];
            id = "e2ede-ugswh";
          };
          "Soundboard" = lib.mkIf config.syncthing.soundboard {
            path = "~/Soundboard";
            devices = [ "leaf-server" ];
            id = "hqy5y-ahisy";
          };
          "Videos" = lib.mkIf config.syncthing.videos {
            path = "~/Videos";
            devices = [ "leaf-server" ];
            id = "5yge6-zfxyn";
          };
        };
      };
    };
  };
}
