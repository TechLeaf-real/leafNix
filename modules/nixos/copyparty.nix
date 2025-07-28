{inputs, ...}: {
  nixpkgs.overlays = [inputs.copyparty.overlays.default];

  services.copyparty = {
    enable = true;
    settings = {
      i = "0.0.0.0";
      p = [3210];
    };

    # accounts = {
    #   techleaf.passwordFile = "";
    # };

    volumes = {
      "/" = {
        path = "/home/techleaf";
        access = {
          r = "*";
        };
      };
    };
  };
}
