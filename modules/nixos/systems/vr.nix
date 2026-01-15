{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.vr;
in {
  options = {
    vr = {
      enable = lib.mkEnableOption "vr";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      (with pkgs; [
        wayvr
        android-tools
        eepyxr
        # stardust-xr-server
        # stardust-xr-gravity
        # stardust-xr-flatland
        # stardust-xr-atmosphere
      ])
      ++ (with inputs.stardustxr-telescope.packages.x86_64-linux; [
        # flatscreen
        # telescope
      ]);
    services.wivrn = {
      enable = false;
      openFirewall = true;
      defaultRuntime = true;
      autoStart = true;

      config = {
        enable = true;
        json = {
          scale = 1.0;
          bitrate = 100000000;
          encoders = [
            {
              encoder = "vaapi";
              codec = "h264";
              width = 0.5;
              height = 0.25;
              offset_x = 0.0;
              offset_y = 0.0;
            }
            {
              encoder = "vaapi";
              codec = "h264";
              width = 0.5;
              height = 0.75;
              offset_x = 0.0;
              offset_y = 0.25;
            }
            {
              encoder = "vaapi";
              codec = "h264";
              width = 0.5;
              height = 1.0;
              offset_x = 0.5;
              offset_y = 0.0;
            }
          ];
        };
      };
    };
    programs.alvr = {
      enable = true;
      openFirewall = true;
    };
  };
}
