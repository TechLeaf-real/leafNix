{
  pkgs,
  pkgs-stable,
  inputs,
  pyprland,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/syncthing.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/emulation.nix
    ../../modules/nixos/vr.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/graphics.nix
    ../../modules/nixos/fish.nix
    ../../modules/nixos/stylix.nix
    ../../modules/nixos/kernel.nix
    ../../modules/nixos/grub.nix
    ../../modules/nixos/vscodium.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/sudo-rs.nix
    ../../modules/nixos/direnv.nix
    ../../modules/nixos/ai.nix
    # ../../modules/nixos/copyparty.nix
  ];

  graphics = {
    gpuBrand = "amd";
    enableOffload = false;
  };

  environment.systemPackages =
    (with pkgs; [
      obsidian
      nix-health
      kdePackages.kdenlive
      alcom
      parabolic
      gimp3
      ghostty
      btop-rocm
      legcord
      btop
      nautilus
      loupe
      gnome-text-editor
      vrc-get
      decibels
      gucharmap
      miniupnpc
      papers
      scarab
      aseprite
      warp
      timg
      godot
      blender-hip
      jq
      tree
      comma
      nix-tree
      magic-wormhole-rs
      libreoffice-qt6
      mpv
      unityhub
      ghex
      xclicker
      antimatter-dimensions
      blockbench
      bottles
      switcheroo
      gnome-disk-utility
    ])
    ++ (with inputs.self.packages.x86_64-linux; [
      rebuild
      update
    ])
    ++ (with pkgs-stable; [
      ])
    ++ (with inputs.nix-alien.packages.${pkgs.system}; [
      nix-alien
    ])
    ++ (with inputs.deadnix.packages.${pkgs.system}; [
      deadnix
    ])
    ++ (with inputs.zen-browser.packages.${pkgs.system}; [
      default
    ])
    ++ (with inputs.jerry.packages.${pkgs.system}; [
      default
    ]);

  programs.thunderbird = {
    enable = true;
  };

  services.udisks2.enable = true;

  programs.corectrl = {
    enable = true;
  };

  network.hostname = "leaf-desktop";

  hardware.xpadneo.enable = true;

  programs.ssh.startAgent = true;

  hardware.bluetooth.enable = true;

  programs.firefox = {
    enable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libffi
      icu
    ];
  };

  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3";
    flake = "~/leafNix";
  };

  location.provider = "geoclue2";

  fileSystems."/home/techleaf/Drive" = {
    device = "dev/disk/by-uuid/2acb7912-13f1-4a4d-bb04-123a26ba088c";
    fsType = "btrfs";
  };

  nix.settings.auto-optimise-store = true;

  networking.hostName = "leaf-desktop";

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = [];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  fileSystems."/home/techleaf/leaf-server" = {
    device = "//192.168.1.115/Store";
    fsType = "cifs";
  };

  console.keyMap = "us";

  users.users.techleaf = {
    isNormalUser = true;
    description = "Techleaf";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keyFiles = [
      "~/.ssh/leaf-desktop.pub"
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "techleaf"
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs-stable;
      inherit pyprland;
    };
    users = {
      "techleaf" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
