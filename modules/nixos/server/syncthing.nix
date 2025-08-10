{...}: {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        leaf-desktop.id = "CPCL5BF-PM44KRA-B5RFMMS-TFA3L33-MOF4VFL-2KRLHY5-LTOTZCO-Q7MCEAM";
      };
      folders = {
        "Blender" = lib.mkIf cfg.blender {
          path = "/pool/dataset/LeafBox/Blender";
          devices = ["leaf-desktop"];
          id = "lg5rx-zx62v";
        };
        "Code" = lib.mkIf cfg.code {
          path = "/pool/dataset/LeafBox/Code";
          devices = ["leaf-desktop"];
          id = "wjun3-prxf2";
        };
        "DCIM" = lib.mkIf cfg.dcim {
          path = "/pool/dataset/LeafBox/DCIM";
          devices = ["leaf-desktop"];
          id = "nookf-u7zge";
        };
        "Emulation" = lib.mkIf cfg.emulation {
          path = "/pool/dataset/LeafBox/Emulation";
          devices = ["leaf-desktop"];
          id = "aqxvs-teezq";
        };
        "ssh" = lib.mkIf cfg.ssh {
          path = "/pool/dataset/LeafBox/ssh";
          devices = ["leaf-desktop"];
          id = "ssh";
        };
        "Obsidian" = lib.mkIf cfg.obsidian {
          path = "/pool/dataset/LeafBox/Obsidian";
          devices = ["leaf-desktop"];
          id = "vsujy-eplhq";
        };
        "Pictures" = lib.mkIf cfg.pictures {
          path = "/pool/dataset/LeafBox/Pictures";
          devices = ["leaf-desktop"];
          id = "al5vz-yucjc";
        };
        "Roms" = lib.mkIf cfg.roms {
          path = "/pool/dataset/LeafBox/Emulation/Roms";
          devices = ["leaf-desktop"];
          id = "e2ede-ugswh";
        };
        "Soundboard" = lib.mkIf cfg.soundboard {
          path = "/pool/dataset/LeafBox/Soundboard";
          devices = ["leaf-desktop"];
          id = "hqy5y-ahisy";
        };
        "Videos" = lib.mkIf cfg.videos {
          path = "/pool/dataset/LeafBox/Videos";
          devices = ["leaf-desktop"];
          id = "5yge6-zfxyn";
        };
      };
    };
  };
}
