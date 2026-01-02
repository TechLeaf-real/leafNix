{
  lib,
  config,
  pkgs-stable,
  ...
}: let
  cfg = config.tailscale;
in {
  options = {
    tailscale = {
      enable = lib.mkEnableOption "tailscale";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      package = pkgs-stable.tailscale;
    };
  };
}
