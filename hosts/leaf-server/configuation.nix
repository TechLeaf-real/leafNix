{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/misc/network.nix
  ];

  networking.hostName = "leaf-server";

  environment.systemPackages = with pkgs; [
  ];

  services.openssh.enable = true;
  programs.git.enable = true;

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
    description = "techleaf";
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
}
