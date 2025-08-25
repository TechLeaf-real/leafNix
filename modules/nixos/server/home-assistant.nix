{pkgs, ...}: {
  services.music-assistant = {
    enable = true;
    providers = [
      "jellyfin"
    ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemeOvmf = true;
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
    bridges.br0.interfaces = ["enp4s0"];
    networking.interfaces.br0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          "address" = "192.168.1.240";
          "prefixLength" = 24;
        }
      ];
    };
  };
  networking.firewall.allowedTCPPorts = [8095];
}
