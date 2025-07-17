{ lib, config, pkgs, ...}:

{
  options = {

  };

  config = {
    environment.systemPackages = with pkgs; [
      wlx-overlay-s
      android-tools
    ];

    services.wivrn = {
      enable = true;
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
  };
}