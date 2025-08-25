{...}: {
  imports = [
    ../../modules/home-manager/fish.nix
  ];

  home.username = "root";
  home.homeDirectory = "/root";

  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
