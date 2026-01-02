{
  pkgs,
  pkgs-stable,
  lib,
  config,
  ...
}: let
  cfg = config.ai;
in {
  options = {
    ai = {
      enable = lib.mkEnableOption "ai";
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "rocm";
      openFirewall = true;
      loadModels = [
        "deepseek-r1:14b"
        "gemma3:12b"
        "gemma3:4b"
        "gemma3:12b-it-qat"
        "llava:13b"
        "qwen2.5vl:7b"
        "llama3.2-vision:11b"
        "llama3.1:8b"
        "llama2-uncensored:7b"
      ];
      rocmOverrideGfx = "10.3.0";
    };

    systemd.services.ollama.serviceConfig = {
      Environment = ["OLLAMA_HOST=0.0.0.0:11434"];
    };

    services.open-webui = {
      enable = true;
      package = pkgs-stable.open-webui;
    };

    environment.systemPackages = with pkgs; [
      oterm
    ];
  };
}
