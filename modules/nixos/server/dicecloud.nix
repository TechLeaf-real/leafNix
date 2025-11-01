{
  pkgs,
  lib,
  ...
}: {
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."dicecloud" = {
    image = "local/dicecloud";
    environment = {
      "MAIL_URL" = "smtp://EMAIL:PASSWORD@SERVER:PORT";
      "METEOR_SETTINGS" = "{\"public\":{\"environment\":\"production\",\"disablePatreon\":true}}";
      "MONGO_URL" = "mongodb://meteor:meteor@dicecloud-db:27017";
      "NODE_ENV" = "production";
      "PORT" = "3000";
      "ROOT_URL" = "http://localhost:3000";
    };
    ports = [
      "3000:3000/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=dicecloud"
      "--network=dicecloud_default"
    ];
  };
  systemd.services."docker-dicecloud" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "docker-network-dicecloud_default.service"
    ];
    requires = [
      "docker-network-dicecloud_default.service"
    ];
    partOf = [
      "docker-compose-dicecloud-root.target"
    ];
    wantedBy = [
      "docker-compose-dicecloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."dicecloud-db" = {
    image = "mongo:latest";
    environment = {
      "MONGO_INITDB_ROOT_PASSWORD" = "meteor";
      "MONGO_INITDB_ROOT_USERNAME" = "meteor";
    };
    volumes = [
      "/pool/dataset/docker/dicecloud/db:/data/db:rw"
    ];
    cmd = ["--storageEngine=wiredTiger"];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=dicecloud-db"
      "--network=dicecloud_default"
    ];
  };
  systemd.services."docker-dicecloud-db" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "docker-network-dicecloud_default.service"
    ];
    requires = [
      "docker-network-dicecloud_default.service"
    ];
    partOf = [
      "docker-compose-dicecloud-root.target"
    ];
    wantedBy = [
      "docker-compose-dicecloud-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-dicecloud_default" = {
    path = [pkgs.docker];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f dicecloud_default";
    };
    script = ''
      docker network inspect dicecloud_default || docker network create dicecloud_default
    '';
    partOf = ["docker-compose-dicecloud-root.target"];
    wantedBy = ["docker-compose-dicecloud-root.target"];
  };

  # Builds
  systemd.services."docker-build-dicecloud" = {
    path = [pkgs.docker pkgs.git];
    serviceConfig = {
      Type = "oneshot";
      TimeoutSec = 300;
    };
    script = ''
      cd /leafNix/assets/docker/dicecloud
      docker build -t local/dicecloud .
    '';
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-dicecloud-root" = {
    unitConfig = {
      Description = "";
    };
    wantedBy = ["multi-user.target"];
  };
}
