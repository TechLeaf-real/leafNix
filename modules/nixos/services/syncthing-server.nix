{
  lib,
  config,
  ...
}: let
  cfg = config.syncthing-server;
in {
  options = {
    syncthing-server = {
      enable = lib.mkEnableOption "syncthing-server";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [8384];

    services.syncthing = {
      enable = true;
      overrideDevices = true;
      overrideFolders = true;
      openDefaultPorts = true;
      user = "techleaf";
      guiAddress = "0.0.0.0:8384";
      settings = {
        devices = {
          leaf-desktop.id = "CPCL5BF-PM44KRA-B5RFMMS-TFA3L33-MOF4VFL-2KRLHY5-LTOTZCO-Q7MCEAM";
          leaf-pixel.id = "DKY2QW5-FGVVFWS-TC54UB7-JK6ODAR-WSYDVAP-U2HH4V5-KLEELOB-RGN67AM";
          leaf-deck.id = "TJ2YN3F-OPDQFC2-ICGLDBK-2DKAYGG-3SS2QLB-ZOZZFPM-2ODSWKM-BG7MKAF";
        };
        folders = {
          "Blender" = {
            path = "/pool/dataset/LeafBox/Blender";
            devices = ["leaf-desktop"];
            id = "lg5rx-zx62v";
          };
          "Code" = {
            path = "/pool/dataset/LeafBox/Code";
            devices = ["leaf-desktop"];
            id = "wjun3-prxf2";
          };
          "Emulation" = {
            path = "/pool/dataset/LeafBox/Emulation";
            devices = ["leaf-desktop" "leaf-pixel" "leaf-deck"];
            id = "aqxvs-teezq";
          };
          "ssh" = {
            path = "/pool/dataset/LeafBox/ssh";
            devices = ["leaf-desktop"];
            id = "ssh";
          };
          "Obsidian" = {
            path = "/pool/dataset/LeafBox/Obsidian";
            devices = ["leaf-desktop" "leaf-pixel"];
            id = "vsujy-eplhq";
          };
          "Soundboard" = {
            path = "/pool/dataset/LeafBox/Soundboard";
            devices = ["leaf-desktop"];
            id = "hqy5y-ahisy";
          };
        };
      };
    };
  };
}
