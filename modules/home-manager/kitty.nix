{
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      # background_opacity = 0.75;
      # background_blur = 16;
    };
  };
}
