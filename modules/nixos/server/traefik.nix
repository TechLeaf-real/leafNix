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
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
            permanent = true;
          };
        };

        websecure = {
          address = ":443";
        };
      };
    };

    dynamicConfigOptions = {
      routers = {
        api = {
          rule = "Host('api.techleaf.dev')";
          service = "api@internal";
          entrypoints = ["websecure"];
        };
        media = {
          rule = "Host('media.techleaf.dev')";
          service = "media";
          entrypoints = ["websecure"];
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
      tls = {
        options = {
          default = {
            cipherSuites = [
              "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
            ];
          };
        };
        stores = {
          default = {
            defaultCertificate = {
              certFile = "/root/techleaf.dev.pem";
              keyFile = "/root/techleaf.dev.key";
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
