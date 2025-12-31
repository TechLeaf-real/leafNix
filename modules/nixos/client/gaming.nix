{
  pkgs,
  pkgs-stable,
  ...
}: {
  options = {
  };

  config = {
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
      openFirewall = true;
    };

    environment.systemPackages =
      (with pkgs; [
        moonlight
        prismlauncher
        ftb-app
        mindustry
        osu-lazer-bin
        satisfactorymodmanager
        sgdboop
        poptracker
        archipelago
        mcpelauncher-ui-qt
        heroic
        owmods-gui
      ])
      ++ (with pkgs-stable; [
        gale
        modrinth-app
        libvdpau-va-gl
        edmarketconnector
      ]);
  };
}
