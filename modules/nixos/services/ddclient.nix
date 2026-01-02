{
  config,
  lib,
  ...
}: let
  cfg = config.ddclient;
in {
  options = {
    ddclient = {
      enable = lib.mkEnableOption "ddclient";
    };
  };

  config = lib.mkIf cfg.enable {
    services.ddclient = {
      enable = true;
      domains = [
        "media.techleaf.dev"
        "pass.techleaf.dev"
        "photo.techleaf.dev"
      ];
      protocol = "cloudflare";
      zone = "techleaf.dev";
      passwordFile = "/pool/dataset/cloudflare/apiKey";
    };
  };
}
