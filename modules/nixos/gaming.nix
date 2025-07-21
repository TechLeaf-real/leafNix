{
  pkgs,
  pkgs-stable,
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
    };

    environment.systemPackages =
      (with pkgs; [
        heroic
        lutris
      ])
      ++ (with pkgs-stable; [
        prismlauncher
      ]);
  };
}
