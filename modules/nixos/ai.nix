{...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    home = "/home/techleaf";
    openFirewall = true;
    loadModels = [
      "deepseek-r1:14b"
    ];
  };
  services.open-webui.enable = true;
}
