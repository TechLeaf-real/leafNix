{
  lib,
  pkgs,
  ...
}: {
  options = {
    fcitx5 = {
      enable = lib.mkEnableOption "fcitx5";
    };
  };

  config = {
    environment.sessionVariables = {
      GTK_IM_MODULE = "fcitx5";
      QT_IM_MODULE = "fcitx5";
      # XMODIFIERS = "@im=fcitx5";
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
          fcitx5-mozc
        ];

        waylandFrontend = true;
        ignoreUserConfig = true;

        settings = {
          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "mozc";
          };
        };
      };
    };
  };
}
