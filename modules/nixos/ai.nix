{pkgs, ...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    # home = "/home/techleaf";
    openFirewall = true;
    loadModels = [
      "deepseek-r1:14b"
    ];
  };

  systemd.services.ollama.serviceConfig = {
    Environment = ["OLLAMA_HOST=0.0.0.0:11434"];
  };

  # services.open-webui = {
  #   enable = true;
  # };

  environment.systemPackages = with pkgs; [
    # (alpaca.override {ollama = pkgs.ollama-rocm;})
    alpaca
  ];
}
