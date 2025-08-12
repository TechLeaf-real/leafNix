{...}: {
  services.immich = {
    enable = true;
    mediaLocation = "/pool/dataset/immich";
    openFirewall = true;
  };
}
