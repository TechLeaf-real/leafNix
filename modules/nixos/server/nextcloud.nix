{...}: {
  services.nextcloud = {
    enable = true;
    home = "/pool/dataset/nextcloud";
    config = {
      adminuser = "techleaf";
    };
    settings = {
      trusted_proxies = ["192.168.1.239"];
    };
  };
}
