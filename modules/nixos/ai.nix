{pkgs, ...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    openFirewall = true;
    loadModels = [
      "deepseek-r1:14b"
    ];
    rocmOverrideGfx = "10.3.0";
  };

  systemd.services.ollama.serviceConfig = {
    Environment = ["OLLAMA_HOST=0.0.0.0:11434"];
  };

  environment.systemPackages = with pkgs; [
    oterm
  ];
}
