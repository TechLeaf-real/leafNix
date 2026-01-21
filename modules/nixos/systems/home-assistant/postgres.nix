{
  lib,
  config,
  ...
}: let
  cfg = config.home-assistant;
in {
  config = lib.mkIf cfg.enable {
    services.home-assistant.config = lib.mkIf (cfg.imperitive.enable == false) {
      recorder.db_url = "postgresql://@/hass";
    };

    services.postgresql = {
      ensureDatabases = ["hass"];
      ensureUsers = [
        {
          name = "hass";
          ensureDBOwnership = true;
        }
      ];
    };
  };
}
