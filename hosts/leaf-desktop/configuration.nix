{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system-packages.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/client/hyprland.nix
    ../../modules/nixos/client/syncthing.nix
    ../../modules/nixos/client/gaming.nix
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
    ../../modules/nixos/misc/virtualisation.nix
  ];

  graphics = {
    gpuBrand = "amd";
    enableOffload = false;
  };

  network.hostname = "leaf-desktop";

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
    };
  };

  programs.ssh.startAgent = true;
  programs.thunderbird.enable = true;
  services.hardware.openrgb.enable = true;
  services.udisks2.enable = true;
  programs.corectrl.enable = true;
  services.gvfs.enable = true;
  hardware.bluetooth.enable = true;
  programs.firefox.enable = true;

  networking.firewall.allowedTCPPorts = [25565 24454];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libunwind
      libcxx
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
    };
    users = {
      "techleaf" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
