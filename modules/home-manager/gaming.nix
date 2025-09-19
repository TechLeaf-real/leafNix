{pkgs, ...}: {
  programs.lutris = {
    enable = true;
    protonPackages = [
      pkgs.proton-ge-bin
      # pkgs.proton-ge-rtsp-bin
    ];
  };
}
