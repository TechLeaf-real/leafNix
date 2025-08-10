{...}: {
  services.vaultwarden = {
    enable = true;
    config = {
      SIGNUPS_ALLOWED = false;
    };
  };
}
