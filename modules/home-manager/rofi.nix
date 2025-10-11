{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override {
      plugins = with pkgs; [
        rofi-calc
        rofi-games
      ];
    };
    extraConfig = {
      modi = "drun,games,calc,bluetooth:rofi-bluetooth,power:rofi-power-menu,network:rofi-network-manager";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
    };
  };
}
