{
  config,
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
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
        ];

        # settings = {

        # };
      };
    };
  };
}
