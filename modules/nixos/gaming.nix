{
  pkgs,
  pkgs-stable,
  # inputs,
  ...
}: {
  options = {
  };

  config = {
    programs.gamemode.enable = true;

    # nixpkgs.overlays = [
    # inputs.millennium.overlays.default
    # ];

    programs.steam = {
      enable = true;
      # package = pkgs.millennium;
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
      ])
      ++ (with pkgs-stable; [
        prismlauncher
      ]);
  };
}
