{pkgs, ...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    home = "/home/techleaf";
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
  #   environment = {
  #     ANONYMIZED_TELEMETRY = "False";
  #     DO_NOT_TRACK = "True";
  #     SCARF_NO_ANALYTICS = "True";
  #     OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
  #     OLLAMA_BASE_URL = "http://127.0.0.1:11434";
  #   };
  # };

  environment.systemPackages = with pkgs; [
    # (alpaca.override {ollama = pkgs.ollama-rocm;})
    oterm
  ];
}
