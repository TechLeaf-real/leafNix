{pkgs, ...}: {
  systemd.services.memos = {
    enable = true;
    after = ["network.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.memos}/bin/memos'';
    };
  };
}
