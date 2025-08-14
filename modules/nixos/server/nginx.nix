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
      sslCertificate = "/root/techleaf.dev.pem";
      sslCertificateKey = "/root/techleaf.dev.key";
      # listen.*.ssl = true;
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
