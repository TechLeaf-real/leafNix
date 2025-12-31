{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ../../modules/home-manager/syncthing.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/direnv.nix
  ];

  home.username = "techleaf";
  home.homeDirectory = "/home/techleaf";

  syncthing = {
    blender = true;
    code = true;
    ssh = true;
    obsidian = true;
    soundboard = true;
    emulation = true;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
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
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
