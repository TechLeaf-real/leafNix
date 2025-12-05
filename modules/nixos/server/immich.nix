{...}: {
  services.immich = {
    enable = true;
    mediaLocation = "/pool/dataset/immich";
    openFirewall = true;
    # host = "0.0.0.0";
    environment = {IMMICH_LOG_LEVEL = "verbose";};
  };
}
