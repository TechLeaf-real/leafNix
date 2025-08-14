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
      sslCertificate = "/pool/dataset/cloudflare/techleaf.dev.pem";
      sslCertificateKey = "/pool/dataset/cloudflare/techleaf.dev.key";
    };
    virtualHosts."pass.techleaf.dev" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8000";
        proxyWebsockets = true;
      };
      sslCertificate = "/pool/dataset/cloudflare/techleaf.dev.pem";
      sslCertificateKey = "/pool/dataset/cloudflare/techleaf.dev.key";
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
