{pkgs, ...}: {
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-jellyfin
    ];
    configuration = ''

    '';
  };
}
