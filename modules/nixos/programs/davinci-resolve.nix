{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.davinci-resolve;
in {
  options = {
    davinci-resolve = {
      enable = lib.mkEnableOption "davinci-resolve";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.davinci-resolve];
    boot.initrd.kernelModules = ["amdgpu"];
    environment.variables = {
      RUSTICL_ENABLE = "radeonsi";
      ROC_ENABLE_PRE_VEGA = "1";
    };
  };
}
