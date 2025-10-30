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
        proxyPass = "http://localhost:8222";
        proxyWebsockets = true;
      };
      sslCertificate = "/pool/dataset/cloudflare/techleaf.dev.pem";
      sslCertificateKey = "/pool/dataset/cloudflare/techleaf.dev.key";
    };
    virtualHosts."photo.techleaf.dev" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:2283";
        proxyWebsockets = true;
      };
      sslCertificate = "/pool/dataset/cloudflare/techleaf.dev.pem";
      sslCertificateKey = "/pool/dataset/cloudflare/techleaf.dev.key";
    };
    virtualHosts."dicecloud.techleaf.dev" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://192.168.1.112:3000";
        proxyWebsockets = true;
      };
      sslCertificate = "/pool/dataset/cloudflare/techleaf.dev.pem";
      sslCertificateKey = "/pool/dataset/cloudflare/techleaf.dev.key";
    };
    # virtualHosts."cloud.techleaf.dev" = {
    #   forceSSL = true;
    #   locations."/" = {
    #     proxyPass = "http://localhost:80";
    #     proxyWebsockets = true;
    #   };
    #   sslCertificate = "/pool/dataset/cloudflare/techleaf.dev.pem";
    #   sslCertificateKey = "/pool/dataset/cloudflare/techleaf.dev.key";
    # };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
