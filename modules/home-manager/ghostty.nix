{
  lib,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
  };
}
