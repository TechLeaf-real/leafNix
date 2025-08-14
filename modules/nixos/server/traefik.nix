{...}: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      log = {
        level = "WARN";
      };

      api = {
        dashboard = true;
        insecure = true;
      };

      serversTransport.insecureSkipVerify = true;

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
      http = {
        routers = {
          media = {
            rule = "Host(`media.techleaf.dev`)";
            service = "media@file";
            entrypoints = ["websecure"];
            tls = {};
          };
        };
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
            minVersion = "VersionTLS13";
            sciStrict = true;
            cipherSuites = [
              "TLS_AES_128_GCM_SHA256"
              "TLS_AES_256_GCM_SHA384"
              "TLS_CHACHA20_POLY1305_SHA256"
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

  networking.firewall.allowedTCPPorts = [8080 80 443];
}
