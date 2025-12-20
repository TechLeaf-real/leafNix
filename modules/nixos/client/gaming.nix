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
      # package = pkgs.steam-millennium;
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
        # vintagestory
        poptracker
        javaPackages.compiler.temurin-bin.jdk-25
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
