{...}: {
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      "isal"
    ];
    extraPackages = ps: with ps; [psycopg2];
    config = {
      name = "The Tree";
      time_zone = "Europe/London";
      default_config = {};
      recorder.db_url = "postgresql://@/hass";
    };
  };
  services.postgresql = {
    enable = true;
    ensureDatabases = ["hass"];
    ensureUsers = [
      {
        name = "hass";
        ensureDBOwnership = true;
      }
    ];
  };
  services.music-assistant = {
    enable = true;
    providers = [
      "jellyfin"
    ];
  };
  networking.firewall.allowedTCPPorts = [8123 8095];
}
