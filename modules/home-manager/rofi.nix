{ lib, pkgs, ...}:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override { plugins = with pkgs; [
      rofi-calc
      rofi-games
      rofi-file-browser
    ]; };
    extraConfig = {
      modi = "drun,games,calc,file-browser-extended,bluetooth:rofi-bluetooth,power:rofi-power-menu,network:rofi-network-manager";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
    };
  };
}