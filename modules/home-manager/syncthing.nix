{
  lib,
  config,
  ...
}: let
  cfg = config.syncthing;
in {
  options = {
    syncthing = {
      blender = lib.mkEnableOption "blender";
      code = lib.mkEnableOption "code";
      emulation = lib.mkEnableOption "emulation";
      ssh = lib.mkEnableOption "ssh";
      obsidian = lib.mkEnableOption "obsidian";
      roms = lib.mkEnableOption "roms";
      soundboard = lib.mkEnableOption "soundboard";
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
            id = "YRUU5FO-XKW2ZAA-5EZQWS4-36K3IAW-YKJNUA6-GFTFLWW-YJENKLV-URVFPA3";
          };
        };
        folders = {
          "Blender" = lib.mkIf cfg.blender {
            path = "~/Blender";
            devices = ["leaf-server"];
            id = "lg5rx-zx62v";
          };
          "Code" = lib.mkIf cfg.code {
            path = "~/Code";
            devices = ["leaf-server"];
            id = "wjun3-prxf2";
          };
          "Emulation" = lib.mkIf cfg.emulation {
            path = "~/Emulation";
            devices = ["leaf-server"];
            id = "aqxvs-teezq";
          };
          "ssh" = lib.mkIf cfg.ssh {
            path = "~/.ssh";
            devices = ["leaf-server"];
            id = "ssh";
          };
          "Obsidian" = lib.mkIf cfg.obsidian {
            path = "~/Obsidian";
            devices = ["leaf-server"];
            id = "vsujy-eplhq";
          };
          "Roms" = lib.mkIf cfg.roms {
            path = "~/Roms";
            devices = ["leaf-server"];
            id = "e2ede-ugswh";
          };
          "Soundboard" = lib.mkIf cfg.soundboard {
            path = "~/Soundboard";
            devices = ["leaf-server"];
            id = "hqy5y-ahisy";
          };
        };
      };
    };
  };
}
