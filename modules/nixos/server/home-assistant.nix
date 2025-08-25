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
      qemuOvmf = true;
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
}
