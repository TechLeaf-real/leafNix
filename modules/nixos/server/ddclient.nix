{...}: {
  services.ddclient = {
    enable = true;
    domains = [
      "media.techleaf.dev"
      "pass.techleaf.dev"
    ];
    protocol = "cloudflare";
    zone = "techleaf.dev";
    passwordFile = "/pool/dataset/cloudflare/apiKey";
  };
}
