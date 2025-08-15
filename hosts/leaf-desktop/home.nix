{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/syncthing.nix
    # ../../modules/home-manager/catppuccin.nix
    ../../modules/home-manager/hyprland/leaf-desktop.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/fastfetch.nix
    ../../modules/home-manager/gaming.nix
    # ../../modules/home-manager/codium.nix
  ];

  home.username = "techleaf";
  home.homeDirectory = "/home/techleaf";

  home.stateVersion = "25.05";

  syncthing = {
    blender = true;
    code = true;
    ssh = true;
    obsidian = true;
    # pictures = true;
    soundboard = true;
    # videos = true;
    emulation = true;
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.mpris
    ];
  };

  xdg.userDirs.download = "${config.home.homeDirectory}/Downloads";

  programs.keychain = {
    enable = true;
    enableFishIntegration = true;
    keys = [
      "~/.ssh/leaf-desktop"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  services.udiskie.enable = true;

  hyprland.terminal = "ghostty";

  home.packages = with pkgs; [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
