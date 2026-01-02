{
  config,
  lib,
  ...
}: let
  cfg = config.gitea;
in {
  options = {
    gitea = {
      enable = lib.mkEnableOption "gitea";
    };
  };

  config = lib.mkIf cfg.enable {
    services.gitea = {
      enable = true;
      stateDir = "/pool/dataset/gitea";
      settings = {
        service.DISABLE_REGISTRATION = false;
      };
      appName = "LeafNet - Git Server";
    };
  };
}
