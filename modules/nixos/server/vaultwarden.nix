{...}: {
  services.vaultwarden = {
    enable = true;
    config = {
      # SIGNUPS_ALLOWED = false;
    };
  };
  networking.firewall.allowedTCPPorts = [8222];
}
