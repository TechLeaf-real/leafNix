{...}: {
  security.acme = {
    acceptTerms = true;
    certs."techleaf.dev" = {
      email = "mikiediggins@gmail.com";
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      environmentFile = "/var/lib/acme/cloudflare.s";
      webroot = null;
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."techleaf.dev" = {
      enableACME = true;
      forceSSL = true;
      locations = {
        "/api/" = {
          proxyPass = "http://127.0.0.1:8080";
        };
        "/media/" = {
          proxyPass = "http://127.0.0.1:8096";
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
