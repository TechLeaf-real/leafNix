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
        # heroic
        moonlight
        prismlauncher
        ftb-app
        mindustry
        osu-lazer-bin
        satisfactorymodmanager
        sgdboop
        vintagestory
        poptracker
        javaPackages.compiler.temurin-bin.jdk-25
        archipelago
        mcpelauncher-client
      ])
      ++ (with pkgs-stable; [
        gale
        modrinth-app
        libvdpau-va-gl
        edmarketconnector
      ]);
  };
}
