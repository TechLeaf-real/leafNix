{
  pkgs,
  pkgs-stable,
  inputs,
  # pyprland,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/client/hyprland.nix
    ../../modules/nixos/client/syncthing.nix
    ../../modules/nixos/client/gaming.nix
    # ../../modules/nixos/client/emulation.nix
    ../../modules/nixos/client/vr.nix
    ../../modules/nixos/client/audio.nix
    ../../modules/nixos/client/graphics.nix
    ../../modules/nixos/client/fish.nix
    ../../modules/nixos/client/stylix.nix
    ../../modules/nixos/client/kernel.nix
    ../../modules/nixos/client/grub.nix
    ../../modules/nixos/client/vscodium.nix
    ../../modules/nixos/misc/network.nix
    ../../modules/nixos/client/tailscale.nix
    ../../modules/nixos/client/sudo-rs.nix
    ../../modules/nixos/client/plymouth.nix
    # ../../modules/nixos/client/ai.nix
    # ../../modules/nixos/client/copyparty.nix
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
      vrc-get
      decibels
      gucharmap
      miniupnpc
      lumafly
      warp
      timg
      godot
      blender-hip
      jq
      tree
      comma
      nix-tree
      ghex
      xclicker
      antimatter-dimensions
      blockbench
      switcheroo
      gnome-disk-utility
      alacritty
      # feishin
      haguichi
      finamp
      unrar-free
      unp
      papers
      docker-compose
      delfin
    ])
    ++ (with inputs.self.packages.x86_64-linux; [
      rebuild
      update
    ])
    ++ (with pkgs-stable; [
      aseprite
      bottles
      gnome-text-editor
      unityhub
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

  # services.desktopManager.cosmic = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
    };
  };

  programs.thunderbird = {
    enable = true;
  };

  services.hardware.openrgb = {
    enable = true;
  };

  services.udisks2.enable = true;

  programs.corectrl = {
    enable = true;
  };

  services.gvfs.enable = true;

  network.hostname = "leaf-desktop";

  hardware.xpadneo.enable = true;

  programs.ssh.startAgent = true;

  hardware.bluetooth.enable = true;

  programs.firefox = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [25565 25564];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libunwind
      libcxx
      libffi
      icu
    ];
  };

  # xdg.mime.enable = true;
  # xdg.mime.defaultApplications = {
  #   "text/html" = "firefox.desktop";
  #   "x-scheme-handler/http" = "firefox.desktop";
  #   "x-scheme-handler/https" = "firefox.desktop";
  #   "x-scheme-handler/about" = "firefox.desktop";
  #   "x-scheme-handler/unknown" = "firefox.desktop";
  # };
  # environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";

  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  fonts.packages = with pkgs; [
    melete
  ];

  fonts.enableDefaultPackages = true;

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
    enable = false;
    enableVirtualCamera = true;
    plugins = [];
  };

  services.logmein-hamachi.enable = true;

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

  # fileSystems."/home/techleaf/leaf-server" = {
  #   device = "//192.168.1.115/Store";
  #   fsType = "cifs";
  # };

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
      # inherit pyprland;
    };
    users = {
      "techleaf" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
