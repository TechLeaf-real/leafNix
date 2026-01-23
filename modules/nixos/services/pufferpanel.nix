{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.pufferpanel;
in {
  options = {
    pufferpanel = {
      enable = lib.mkEnableOption "pufferpanel";
    };
  };
  config = lib.mkIf cfg.enable {
    services.pufferpanel = {
      enable = true;
      extraPackages = with pkgs; [bash curl gawk gnutar gzip];
      package = pkgs.buildFHSEnv {
        name = "pufferpanel-fhs";
        runScript = lib.getExe pkgs.pufferpanel;
        targetPkgs = pkgs': with pkgs'; [icu openssl zlib];
      };
      environment = {
        PUFFER_PANEL_REGISTRATIONENABLED = "false";
        PUFFER_PANEL_SETTINGS_COMPANYNAME = "LeafNet";
      };
    };

    environment.systemPackages = with pkgs; [
      buildFHSEnv
      {
        name = "pufferpanel-fhs";
        runScript = lib.getExe pkgs.pufferpanel;
        targetPkgs = pkgs': with pkgs'; [icu openssl zlib];
      }
    ];

    networking.firewall.allowedTCPPorts = [8080];
  };
}
