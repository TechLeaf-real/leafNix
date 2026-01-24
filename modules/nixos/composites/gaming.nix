{
  pkgs,
  pkgs-stable,
  config,
  lib,
  ...
}: let
  cfg = config.gaming;
in {
  options = {
    gaming = {
      enable = lib.mkEnableOption "gaming";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
      protontricks.enable = true;
    };

    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      settings = {
        sunshine_name = "Leaf Desktop";
        upnp = "enabled";
        wan_encryption_mode = 2;
        encoder = "amdvce";
        amd_quality = "speed";
      };
    };

    networking.firewall.allowedTCPPorts = [36743];

    environment.systemPackages =
      (with pkgs; [
        moonlight
        prismlauncher
        ftb-app
        mindustry
        osu-lazer-bin
        satisfactorymodmanager
        poptracker
        archipelago
        mcpelauncher-ui-qt
        heroic
        owmods-gui
        # parsec
        gamescope
        forge-mtg
        lovely-injector
      ])
      ++ (with pkgs-stable; [
        sgdboop
        gale
        modrinth-app
        libvdpau-va-gl
        edmarketconnector
      ]);
  };
}
