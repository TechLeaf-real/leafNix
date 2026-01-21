{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.home-assistant;
in {
  imports = [
    ./postgres.nix
  ];

  options = {
    home-assistant = {
      enable = lib.mkEnableOption "home-assistant";
      imperitive = lib.mkEnableOption "imperitive home-assistant";
    };
  };

  config = lib.mkIf cfg.enable {
    services.home-assistant = lib.mkIf (cfg.imperitive == false) {
      enable = true;
      package = pkgs.home-assistant.override {
        extraPackages = python3Packages:
          with python3Packages; [
            psycopg2
          ];
        extraComponents = [
          "default_config"
          "esphome"
          "met"
        ];
      };

      config = {};
    };
  };
}
