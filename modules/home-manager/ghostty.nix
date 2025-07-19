{lib, pkgs, ...}:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "Cozette";
    };
  };
}