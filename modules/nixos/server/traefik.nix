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
          http = {
            middlewares = ["security-headers@file"];
            tls = {
              options = "default";
            };
          };
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
            sniStrict = false;
            minVersion = "VersionTLS13";
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
      middlewares = {
        security-headers = {
          headers = {
            referrerPolicy = "no-referrer";
            forceSTSHeader = true;
            stsSeconds = 15778800;
            sysIncludeSubdomains = true;
            stsPreload = true;
            contentTypeNosniff = true;
            browserXssFilter = true;
            customRequestHeaders.X-Forwarded-Proto = "https";
            customResponseHeaders = {
              X-Powered-By = "Redstone";
              Server = "Server";
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
