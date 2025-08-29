{...}: {
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "http://localhost:8071";
      # SIGNUPS_ALLOWED = false;
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
    };
  };
  networking.firewall.allowedTCPPorts = [8071];
}
