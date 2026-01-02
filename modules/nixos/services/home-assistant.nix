{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-assistant;
in {
  options = {
    home-assistant = {
      enable = lib.mkEnableOption "home-assistant";
    };
  };

  config = lib.mkIf cfg.enable {
    services.music-assistant = {
      enable = true;
      providers = [
        "jellyfin"
      ];
    };

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.ovmf.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      virt-manager
      usbutils
    ];

    users.users.root = {
      extraGroups = ["libvirtd"];
    };

    networking = {
      firewall.allowedTCPPorts = [8095];
      bridges.br0.interfaces = ["enp4s0"];
      interfaces.br0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            "address" = "192.168.1.240";
            "prefixLength" = 24;
          }
        ];
      };
    };
  };
}
