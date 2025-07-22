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
  ];

  graphics = {
    gpuBrand = "amd";
    enableOffload = false;
  };

  environment.systemPackages =
    (with pkgs; [
      obsidian
      firefox
      ghostty
      btop-rocm
      legcord
      btop
      nautilus
      loupe
      gnome-text-editor
      decibels
      gucharmap
      miniupnpc
      papers
      scarab
      warp
      timg
      corectrl
      godot
      blender-hip
      jq
      tree
      comma
      nix-tree
      davinci-resolve
      libreoffice-qt6
      mpv
      (writeShellScriptBin "rebuild" ''
        #! nix-shell -i bash -p bash
        set -e
        pushd ~/leafNix
        clear
        sudo deadnix -e
        clear
        if git diff --quiet '*.nix'; then
            echo "\nNo changes detected, exiting."
            popd
            exit 0
        fi
        clear
        git diff -U0 '*.nix'
        set +o pipefail
        nh os switch ~/leafNix || exit 0
        set -o pipefail
        echo  -e "\n\033[34mNixOS rebuild completed\033[0m"
        echo -ne "\rExit in 1" && sleep 1
        echo -ne "\033[?1049l"
        clear
        alejandra *
        clear
        current=$(nixos-rebuild list-generations --json | jq '.[] | select (.current == true) | "\(.generation) \(.date) \(.nixosVersion) \(.kernelVersion)"')
        git commit -am "$current"
        git push origin master
        popd
        clear
      '')
      (writeShellScriptBin "update" ''
        #! nix-shell -i bash -p bash
        set -e
        pushd ~/leafNix
        clear
        echo "Updating Flake..."
        nix flake update
        set +o pipefail
        nh os switch ~/leafNix || exit 0
        set -o pipefail
        echo  -e "\n\033[34mNixOS rebuild completed\033[0m"
        echo -ne "\rExit in 1" && sleep 1
        echo -ne "\033[?1049l"
        clear
        current=$(nixos-rebuild list-generations --json | jq '.[] | select (.current == true) | "\(.generation) \(.date) \(.nixosVersion) \(.kernelVersion)"')
        git commit -am "$current"
        git push origin master
        popd
        clear
      '')
    ])
    ++ (with pkgs-stable; [
      unityhub
      # modrinth-app
    ])
    ++ (with inputs.nix-alien.packages.${pkgs.system}; [
      nix-alien
    ])
    ++ (with inputs.deadnix.packages.${pkgs.system}; [
      deadnix
    ])
    ++ (with inputs.zen-browser.packages.${pkgs.system}; [
      default
    ]);

  programs.thunderbird = {
    enable = true;
  };

  network.hostname = "leaf-desktop";

  programs.ssh.startAgent = true;

  hardware.bluetooth.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libffi
    ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3";
    flake = "~/leafNix";
  };

  fileSystems."/home/techleaf/Drive" = {
    device = "dev/disk/by-uuid/2acb7912-13f1-4a4d-bb04-123a26ba088c";
    fsType = "btrfs";
  };

  nix.settings.auto-optimise-store = true;

  networking.hostName = "leaf-desktop";

  programs.obs-studio = {
    enable = true;
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

  console.keyMap = "us";

  users.users.techleaf = {
    isNormalUser = true;
    description = "Techleaf";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keyFiles = [
      "~/.ssh/leaf-desktop.pub"
    ];
  };

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
