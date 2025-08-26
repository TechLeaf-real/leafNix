{...}: {
  services.nextcloud = {
    enable = true;
    home = "/pool/dataset/nextcloud";
    config = {
      adminuser = "techleaf";
      adminpassFile = "/pool/dataset/nextcloud-pass";
      dbtype = "mysql";
    };
    settings = {
      trusted_proxies = ["192.168.1.239"];
    };
    hostName = "cloud.techleaf.dev";
  };
}
