{...}: {
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.papermc;
    dataDir = "/home/techleaf/mcTest";
    openFirewall = true;
    whitelist = {
      TechLeaf = "49448e8d-f881-4233-b587-be44990288b3";
    };
  };
}
