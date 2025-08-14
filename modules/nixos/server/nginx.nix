{...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."media.techleaf.dev" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
