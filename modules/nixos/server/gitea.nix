{...}: {
  services.gitea = {
    enable = true;
    stateDir = "/pool/dataset/gitea";
    settings = {
      service.DISABLE_REGISTRATION = false;
    };
    appName = "LeafNet - Git Server";
  };
}
