{...}: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      log = {
        level = "WARN";
      };

      api = {};

      entryPoints = {
        web = {
          address = ":80";
          # http.redirections.entryPoint = {
          #   to = "websecure";
          #   scheme = "https";
          #   permanent = true;
          # };
        };

        websecure = {
          address = ":443";
        };
      };
    };

    dynamicConfigOptions = {
      routers = {
        default = {
          rule = "Host('192.168.1.239')";
          service = "media";
          # entrypoints = ["websecure"];
          priority = 1;
          # tls = {
          #   certificates = {
          #     certFile = "/root/techleaf.dev.pem";
          #     keyFile = "/root/techleaf.dev.key";
          #   };
          # };
        };
        media = {
          rule = "Host('media.techleaf.dev')";
          service = "media";
          entrypoints = ["websecure"];
          tls = {
            certificates = {
              certFile = "/root/techleaf.dev.pem";
              keyFile = "/root/techleaf.dev.key";
            };
          };
        };
      };
      http = {
        services = {
          media = {
            loadBalancer = {
              servers = [
                "locahost:8096"
              ];
            };
          };
        };
      };
    };
  };

  systemd.services.trarfik.serviceConfig = {
    EnvironmentFile = ["/var/lib/traefik/env"];
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
