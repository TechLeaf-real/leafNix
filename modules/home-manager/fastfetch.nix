{ lib, config, pkgs, ...}:

{
  home.packages = with pkgs; [
    fastfetch
  ];

  home.file = {
    ".config/fastfetch/config.jsonc" = {
        text = ''

        '';
      enable = true;
    };
  };
}