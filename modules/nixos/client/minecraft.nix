{pkgs, ...}: {
  services.minecraft-server = {
    enable = true;
    package = pkgs.papermc;
    eula = true;
    openFirewall = true;
    whitelist = {
      TechLeaf = "49448e8d-f881-4233-b587-be44990288b3";
    };
  };
}
