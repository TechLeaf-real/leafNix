{
  inputs,
  lib,
  config,
  pkgs-stable,
  ...
}: let
  cfg = config.media-server;
in {
  options = {
    media-server = {
      enable = lib.mkEnableOption "media-server";
    };
  };

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    # services.declarative-jellyfin = {
    #   enable = true;
    #   openFirewall = true;
    #   network = {
    #     knownProxies = ["192.168.1.239"];
    #   };
    #   system = {
    #     serverName = "LeafNet Streaming";
    #     pluginRepositories = [
    #       {
    #         content = {
    #           Enabled = true;
    #           Name = "Jellyfin Stable";
    #           Url = "https://repo.jellyfin.org/files/plugin/manifest.json";
    #         };
    #         tag = "RepositoryInfo";
    #       }
    #       {
    #         content = {
    #           Enabled = true;
    #           Name = "Intro Skipper";
    #           Url = "https://intro-skipper.org/manifest.json";
    #         };
    #         tag = "RepositoryInfo";
    #       }
    #     ];
    #   };
    #   users = {
    #     techleaf = {
    #       mutable = false;
    #       permissions.isAdministrator = true;
    #       hashedPassword = "$PBKDF2-SHA512$iterations=210000$4BCE7FB5229C58DF3FA49CA4660803E2$10CD54D9DAE819548CAB50D0F1F09E0F4B964C3BDB73D9DDD3667CBE7194BA02C2D25C89520C8FB7C31E4AF42CAA8882D8DD75839922EB4EE12713DC29D01616";
    #     };
    #   };
    #   encoding = {
    #     enableHardwareEncoding = true;
    #     hardwareAccelerationType = "vaapi";
    #     enableDecodingColorDepth10Hevc = true;
    #     allowHevcEncoding = true;
    #     hardwareDecodingCodecs = [
    #       "h264"
    #       "hevc"
    #       "mpeg2video"
    #       "vc1"
    #       "vp9"
    #       "av1"
    #     ];
    #     enableVppTonemapping = true;
    #     enableTonemapping = true;
    #   };
    #   libraries = {
    #     Movies = {
    #       enabled = true;
    #       contentType = "movies";
    #       pathInfos = ["/pool/dataset/media/movies"];
    #     };
    #     Shows = {
    #       enabled = true;
    #       contentType = "tvshows";
    #       pathInfos = ["/pool/dataset/media/shows"];
    #     };
    #     Music = {
    #       enabled = true;
    #       contentType = "music";
    #       pathInfos = ["/pool/dataset/media/music" "/pool/dataset/media/newMusic" "/pool/dataset/media/rippedMusic"];
    #     };
    #   };
    # };

    # services.jellarr = {
    #   enable = true;
    #   user = "jellyfin";
    #   group = "media";
    #   config = {
    #     base_url = "http://localhost:8096";
    #     system = {
    #       pluginRepositories = [{
    #         name = "Jellyfin Official";
    #         url = "https://repo.jellyfin.org/files/plugin/manifest.json";
    #         enabled = true;
    #       }
    #       {
    #         name = "Intro Skipper";
    #         url = "https://intro-skipper.org/manifest.json";
    #         enabled = true;
    #       }
    #       {
    #         name = "Jellyfin MusicTags Plugin";
    #         url = "https://raw.githubusercontent.com/jyourstone/jellyfin-plugin-manifest/master/manifest.json";
    #         enabled = true;
    #       }];
    #     };
    #     encoding = {
    #       enableHardwareEncoding = true;
    #       hardwareAccelerationType = "vaapi";
    #       hardwareDecodingCodecs = [
    #         "h264"
    #         "hevc"
    #         "mpeg2video"
    #         "vc1"
    #         "vp9"
    #         "av1"
    #       ];
    #       enableDecodingColorDepth10Hevc = true;
    #       enableDecodingColorDepth10HevcRext = true;
    #       enableDecodingColorDepth12HevcRext = true;
    #       enableDecodingColorDepth10Vp9 = true;
    #       allowHevcEncoding = false;
    #       allowAv1Encoding = false;
    #     };
    #     library = {
    #       virtualFolders = [{
    #         name = "Movies";
    #         collectionType = "movies";
    #         libraryOptions = {
    #           pathInfos.path = ["/pool/dataset/media/movies"];
    #         };
    #       }{
    #         name = "Shows";
    #         collectionType = "tvshows";
    #         libraryOptions = {
    #           pathInfos.path = ["/pool/dataset/media/shows"];
    #         };
    #       }{
    #         name = "Music";
    #         collectionType = "music";
    #         libraryOptions = {
    #           pathInfos = ["/pool/dataset/media/music" "/pool/dataset/media/newMusic" "/pool/dataset/media/rippedMusic"];
    #         };
    #       }];
    #     };
    #     branding = {
    #       splashscreenEnabled = false;
    #       customCss = ''
    #         /*Hide the "Trailers" tab in Movies*/
    #         .mainDrawer:has(.navMenuOption-selected[href^="#/movies.html"]) + .skinHeader .emby-tab-button[data-index="2"] {
    #         display: none !important;
    #         }
    #       ''
    #     };
    #     users = [{
    #       name = "techleaf";
    #       passwordFile = /pool/dataset/jellyfin-pass;
    #       policy = {
    #         isAdministrator = true;
    #       };
    #     }];
    #     startup = {
    #       completeStartupWizard = true;
    #     };

    #     bootstrap = {
    #       enable = true;
    #       apiKeyFile = /pool/dataset/jellfin-key;
    #     };
    #   };
    # };

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
        max_download_speed = "500000.0";
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
  };
}
