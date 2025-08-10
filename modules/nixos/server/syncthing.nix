{...}: {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    guiAddress = "0.0.0.0:8384";
    settings = {
      devices = {
        leaf-desktop.id = "CPCL5BF-PM44KRA-B5RFMMS-TFA3L33-MOF4VFL-2KRLHY5-LTOTZCO-Q7MCEAM";
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
        "DCIM" = {
          path = "/pool/dataset/LeafBox/DCIM";
          devices = ["leaf-desktop"];
          id = "nookf-u7zge";
        };
        "Emulation" = {
          path = "/pool/dataset/LeafBox/Emulation";
          devices = ["leaf-desktop"];
          id = "aqxvs-teezq";
        };
        "ssh" = {
          path = "/pool/dataset/LeafBox/ssh";
          devices = ["leaf-desktop"];
          id = "ssh";
        };
        "Obsidian" = {
          path = "/pool/dataset/LeafBox/Obsidian";
          devices = ["leaf-desktop"];
          id = "vsujy-eplhq";
        };
        "Pictures" = {
          path = "/pool/dataset/LeafBox/Pictures";
          devices = ["leaf-desktop"];
          id = "al5vz-yucjc";
        };
        "Roms" = {
          path = "/pool/dataset/LeafBox/Emulation/Roms";
          devices = ["leaf-desktop"];
          id = "e2ede-ugswh";
        };
        "Soundboard" = {
          path = "/pool/dataset/LeafBox/Soundboard";
          devices = ["leaf-desktop"];
          id = "hqy5y-ahisy";
        };
        "Videos" = {
          path = "/pool/dataset/LeafBox/Videos";
          devices = ["leaf-desktop"];
          id = "5yge6-zfxyn";
        };
      };
    };
  };
}
