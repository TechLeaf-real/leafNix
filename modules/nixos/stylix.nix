{ lib, config, pkgs, ...}:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.cozette;
        name = "Cozette";
      };

      sansSerif = {
        package = pkgs.cozette;
        name = "Cozette";
      };

      monospace = {
        package = pkgs.cozette;
        name = "Cozette";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}