{
  inputs,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../modules/nixos/misc/network.nix
    ../../modules/nixos/client/fish.nix
    ../../modules/nixos/server/samba.nix
    ../../modules/nixos/server/syncthing.nix
  ];

  network.hostname = "leaf-server";
  networking.hostId = "737572d5";

  environment.systemPackages =
    (with pkgs; [
      ])
    ++ (with inputs.self.packages.x86_64-linux; [
      server-rebuild
    ]);

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;
  programs.git.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  services.xserver.xkb = {
    layout = "us";
  };

  users.users.techleaf = {
    isNormalUser = true;
    description = "Techleaf";
    extraGroups = ["networkmanager"];
  };

  console.keyMap = "us";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEF3Aq4NBRUdRienRISP75JJo3JEmhqQvvwx+xzERZ4 techleaf@leaf-desktop"
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
