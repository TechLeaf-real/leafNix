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
    ../../modules/nixos
  ];

  network.enable = true;
  fish.enable = true;
  samba.enable = true;
  syncthing-server.enable = true;
  media-server.enable = true;
  immich.enable = true;
  nginx.enable = true;
  ddclient.enable = true;
  vaultwarden.enable = true;
  home-assistant = {
    enable = false;
    imperitive.enable = true;
    imperitive.vm = true;
  };
  pufferpanel.enable = true;

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
    extraGroups = ["networkmanager" "media"];
  };

  console.keyMap = "us";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEF3Aq4NBRUdRienRISP75JJo3JEmhqQvvwx+xzERZ4 techleaf@leaf-desktop"
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
