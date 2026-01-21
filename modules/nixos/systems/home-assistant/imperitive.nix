{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.home-assistant;
in {
  config = lib.mkIf (cfg.enable && cfg.imperitive.enable) {
    virtualisation.oci-containers = lib.mkIf cfg.imperitive.oci {
      backend = "podman";
      containers.homeassistant = {
        volumes = ["home-assistant:/config"];
        environment.TZ = "Europe/London";
        # Note: The image will not be updated on rebuilds, unless the version label changes
        image = "ghcr.io/home-assistant/home-assistant:stable";
        extraOptions = [
          # Use the host network namespace for all sockets
          "--network=host"
          # Pass devices into the container, so Home Assistant can discover and make use of them
          # "--device=/dev/ttyACM0:/dev/ttyACM0"
        ];
      };
    };

    virtualisation.libvirtd = lib.mkIf cfg.imperitive.vm {
      enable = true;
    };

    environment.systemPackages = with pkgs;
      lib.mkIf cfg.imperitive.vm [
        virt-manager
        usbutils
      ];

    users.users.root = lib.mkIf cfg.imperitive.vm {
      extraGroups = ["libvirtd"];
    };

    networking = {
      firewall.allowedTCPPorts = [8123];
      bridges.br0.interfaces = lib.mkIf cfg.imperitive.vm ["esp4s0"];
      interfaces.br0 = lib.mkIf cfg.imperitive.vm {
        useDHCP = false;
        ipv4.addresses = [
          {
            "address" = "192.168.1.240";
            "prefixLength" = 24;
          }
        ];
      };
    };
    services.home-assistant = lib.mkIf cfg.imperitive.nix {
      enable = true;
      package = pkgs.home-assistant.override {
        extraPackages = python3Packages:
          with python3Packages; [
            psycopg2
          ];
        extraComponents = [
          "default_config"
          "esphome"
          "met"
        ];
      };
      config = null;
      lovelaceConfig = null;
      configDir = "/etc/home-assistant";
    };
  };
}
