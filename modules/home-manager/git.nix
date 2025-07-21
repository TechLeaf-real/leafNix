{
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    programs.git = {
      enable = true;
      delta = {
        enable = true;
      };
      userEmail = "mikiediggins@gmail.com";
      userName = "Techleaf";
    };
  };
}
