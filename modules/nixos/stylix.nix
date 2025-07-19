{ lib, config, pkgs, ...}:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}