{
  lib,
  pkgs-stable,
  ...
}: {
  services.declarative-jellyfin = {
    enable = true;
    openFirewall = true;
    network = {
      knownProxies = ["192.168.1.239"];
    };
    system = {
      serverName = "LeafNet Streaming";
    };
    users = {
      techleaf = {
        mutable = false;
        permissions.isAdministrator = true;
        hashedPassword = "$PBKDF2-SHA512$iterations=210000$4BCE7FB5229C58DF3FA49CA4660803E2$10CD54D9DAE819548CAB50D0F1F09E0F4B964C3BDB73D9DDD3667CBE7194BA02C2D25C89520C8FB7C31E4AF42CAA8882D8DD75839922EB4EE12713DC29D01616";
      };
      skiesofarcadia = {
        mutable = false;
        preferences.enabledLibraries = ["Music"];
        hashedPassword = "$PBKDF2-SHA512$iterations=210000$0EA3301092582097849440FF654DD9BD$36BB092A31F7AF3882A9073BABE16265DA2196C69FC12A0AF5A69427584041E2B6C49D88D9A95CBCA9573CC3471F2CC0977A65918E2DC26C92414D0EA4B9A801";
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
        pathInfos = ["/pool/dataset/media/movies"];
      };
      Shows = {
        enabled = true;
        contentType = "tvshows";
        pathInfos = ["/pool/dataset/media/shows"];
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
    group = "media";
    dataDir = "/pool/dataset/media/deluge";
    config = {
      download_location = "/pool/dataset/media/downloads";
      enabled_plugins = ["label"];
      max_download_speed = "4000.0";
    };
    web = {
      enable = true;
      openFirewall = true;
    };
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.flaresolverr = {
    enable = true;
    openFirewall = true;
    package = pkgs-stable.flaresolverr;
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
