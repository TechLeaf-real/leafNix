{...}: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "c950419a-532f-40ad-bf09-12ebc0476cb0" = {
        credentialsFile = "/root/.cloudflared/c950419a-532f-40ad-bf09-12ebc0476cb0.json";
        ingress = {
          "media.techleaf.dev" = {
            service = "http://localhost:8096";
          };
          "seerr.techleaf.dev" = {
            service = "http://localhost:5055";
          };
        };
        default = "http_status:404";
      };
    };
  };
}
