{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.memos;
in {
  options = {
    memos = {
      enable = lib.mkEnableOption "memos";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.memos = {
      enable = true;
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.memos}/bin/memos'';
      };
    };
    environment.systemPackages = with pkgs; [
      memos
    ];
  };
}
