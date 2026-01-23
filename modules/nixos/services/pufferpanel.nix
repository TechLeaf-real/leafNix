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
  config = {
    services.pufferpanel = lib.mkIf cfg.enable {
      enable = true;
      extraPackages = with pkgs; [bash curl gawk gnutar gzip];
      package = pkgs.buildFHSEnv {
        name = "pufferpanel-fhs";
        runScript = lib.getExe pkgs.pufferpanel;
        targetPkgs = pkgs': with pkgs'; [icu openssl zlib];
      };
    };
  };
}
