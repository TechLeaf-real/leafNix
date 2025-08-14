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
          service = "api@interal";
          entrypoints = ["websecure"];
          tls = {
            certificates = {
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
