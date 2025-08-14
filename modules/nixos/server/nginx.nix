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
      sslCertificate = "/pool/dataset/certs/techleaf.dev.pem";
      sslCertificateKey = "/pool/dataset/certs/techleaf.dev.key";
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
