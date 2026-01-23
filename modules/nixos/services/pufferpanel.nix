{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    pufferpanel = {
      enable = lib.mkEnableOption "pufferpanel";
    };
  };
  config = {
    services.pufferpanel = {
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
