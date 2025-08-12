{...}: {
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
          asDefault = true;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };

        websecure = {
          address = ":443";
          asDefault = true;
          # https.tls.certResolver = "";
        };
      };

      api.dashboard = true;
      api.insecure = true;
    };

    dynamicConfigOptions = {
      # http.routers = {};
      # http.services = {};
    };
  };
}
