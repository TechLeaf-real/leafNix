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
    };

    services.sunshine = {
      enable = true;
      openFirewall = true;
    };

    environment.systemPackages =
      (with pkgs; [
        heroic
        moonlight
        prismlauncher
        ftb-app
        gale
        mindustry
        osu-lazer-bin
        satisfactorymodmanager
        sgdboop
        vintagestory
        poptracker
        javaPackages.compiler.temurin-bin.jdk-25
      ])
      ++ (with pkgs-stable; [
        libvdpau-va-gl
        edmarketconnector
      ]);
  };
}
