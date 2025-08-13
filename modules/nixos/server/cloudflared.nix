{...}: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "4296602e-eee8-4837-9196-6f40dd895506" = {
        credentialsFile = "/root/.cloudflared/4296602e-eee8-4837-9196-6f40dd895506.json";
        ingress = {
          "media.techleaf.dev" = "http://192.168.1.239:8096";
          "seerr.techleaf.dev" = "http://192.168.1.239:5055";
        };
        default = "http_status:404";
      };
    };
  };
}
