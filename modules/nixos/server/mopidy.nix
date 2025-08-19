{pkgs, ...}: {
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-jellyfin
    ];
    configuration = ''
      [http]
      enabled = true
      hostname = 0.0.0.0
      port = 6680
      csrf_protection = true
    '';
  };
}
