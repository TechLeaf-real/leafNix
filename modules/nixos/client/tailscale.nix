{pkgs-stable, ...}: {
  services.tailscale = {
    enable = true;
    openFirewall = true;
    package = pkgs-stable.tailscale;
  };
}