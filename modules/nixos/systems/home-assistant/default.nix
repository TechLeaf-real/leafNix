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
    };
  };

  config = lib.mkIf cfg.enable {
    services.home-assistant = {
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
