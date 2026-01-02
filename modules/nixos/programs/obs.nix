{
  lib,
  config,
  ...
}: let
  cfg = config.obs;
in {
  options = {
    obs = {
      enable = lib.mkEnableOption "obs";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = [];
    };
  };
}
