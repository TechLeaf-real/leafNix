{...}: {
  services.caddy = {
    enable = true;
    virtualHosts = {
      "techleaf.dev" = {
      };
    };
  };
}
