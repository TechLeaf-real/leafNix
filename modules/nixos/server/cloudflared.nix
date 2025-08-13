{...}: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "4296602e-eee8-4837-9196-6f40dd895506" = {
        credentialsFile = "/root/.cloudflared/4296602e-eee8-4837-9196-6f40dd895506.json";
        ingress = {
          "media.techleaf.dev" = "http://localhost:8096";
        };
        default = "http_status:404";
      };
    };
  };
}
