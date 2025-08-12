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

      certificatesResolvers = {
        cloudflare = {
          acme = {
            storage = "/var/lib/traefik/acme.json";
            caserver = "";
            dnsChallenge = {
              provider = "cloudflare";
              resolvers = ["1.1.1.1:53" "1.0.0.1:53"];
              # propagation.delayBeforeChecks = 60;
            };
          };
        };
      };
    };

    dynamicConfigOptions = {
      routers = {
        api = {
          rule = "Host()";
          service = "api@interal";
          entrypoints = ["websecure"];
          tls = {
            certResolver = "cloudflare";
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
