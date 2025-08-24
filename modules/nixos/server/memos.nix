{pkgs, ...}: {
  systemd.user.services.memos = {
    enable = true;
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    linger = true;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.memos}/bin/memos'';
    };
  };
}
