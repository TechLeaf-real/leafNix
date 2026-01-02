{
  lib,
  config,
  ...
}: let
  cfg = config.power;
in {
  options = {
    power = {
      enable = lib.mkEnableOption "power-management";
      hibernate = {
        auto = lib.mkEnableOption "auto hibernate";
        delay = lib.mkOption {
          type = lib.types.int;
          default = 30;
          description = "Delay in minutes before auto hibernation is triggered.";
          example = 30;
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.sleep.extraConfig = lib.mkIf cfg.hibernate.auto ''
      HibernateDelaySec=${toString (cfg.hibernate.delay * 60)}s
    '';
  };
}
