{lib, ...}: {
  services.declarative-jellyfin = {
    enable = true;
    openFirewall = true;
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
    libraries = {
      Movies = {
        enabled = true;
        contentType = "movies";
        pathInfos = ["/pool/dataset/media/Movies"];
      };
      Shows = {
        enabled = true;
        contentType = "tvshows";
        pathInfos = ["/pool/dataset/media/tv"];
      };
      Music = {
        enabled = true;
        contentType = "music";
        pathInfos = ["/pool/dataset/media/music"];
      };
    };
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.lidarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };

  services.deluge = {
    enable = true;
    declarative = true;
    openFirewall = true;
    authFile = "/run/keys/deluge-auth";
    web = {
      enable = true;
      openFirewall = true;
    };
    config = {
      download_location = "/pool/dataset/media/downloads";
    };
  };

  hardware.graphics.enable = true;
  users.users = {
    jellyfin = {
      isSystemUser = true;
      group = lib.mkForce "media";
      extraGroups = ["video" "render"];
    };
  };

  users.groups.media = {};
}
