{...}: {
  services = {
    declarative-jellyfin = {
      system = {
        serverName = "LeafNet Streaming";
      };

      users = {
        techleaf = {
          mutable = false;
          permissions.isAdministrator = true;
          hashedPassword = "$PBKDF2-SHA512$iterations=210000$4BCE7FB5229C58DF3FA49CA4660803E2$10CD54D9DAE819548CAB50D0F1F09E0F4B964C3BDB73D9DDD3667CBE7194BA02C2D25C89520C8FB7C31E4AF42CAA8882D8DD75839922EB4EE12713DC29D01616";
        };
      };

      encoding = {
        enableHardwareEncoding = true;
        hardwareAccelerationType = "vaapi";
        enableDecodingColorDepth10Hevc = true;
        allowHevcEncoding = true;
        hardwareDecodingCodecs = [
          "h264"
          "hevc"
          "mpeg2video"
          "vc1"
          "vp9"
          "av1"
        ];
      };
    };

    # radarr = {
    #   enable = true;
    # };

    # sonarr = {
    #   enable = true;
    # };

    # jellyseerr = {
    #   enable = true;
    # };

    # jackett = {
    #   enable = true;
    # };
  };

  hardware.graphics.enable = true;
  users.users.jellyfin = {
    isSystemUser = true;
    group = "jellyfin";
    extraGroups = ["video" "render"];
  };
}
