{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.minecraft-server;
in {
  options = {
    minecraft-server = {
      enable = lib.mkEnableOption "minecraft-server";
    };
  };

  config = lib.mkIf cfg.enable {
    services.minecraft-server = {
      enable = true;
      package = pkgs.papermc;
      eula = true;
      openFirewall = true;
      whitelist = {
        TechLeaf = "49448e8d-f881-4233-b587-be44990288b3";
      };
    };
  };
}
