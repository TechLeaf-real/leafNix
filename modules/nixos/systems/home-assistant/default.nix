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
    ./imperitive.nix
  ];

  options = {
    home-assistant = {
      enable = lib.mkEnableOption "home-assistant";
      imperitive = {
        enable = lib.mkEnableOption "imperitive home-assistant";
        oci = lib.mkEnableOption "oci container home-assistant";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.home-assistant = lib.mkIf (cfg.imperitive.enable == false) {
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
