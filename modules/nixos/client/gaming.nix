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
        itch
      ])
      ++ (with pkgs-stable; [
        ]);
  };
}
