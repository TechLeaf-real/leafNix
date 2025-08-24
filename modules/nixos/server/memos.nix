{pkgs, ...}: {
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
}
