{
  config,
  lib,
  ...
}: let
  cfg = config.audio;
in {
  options = {
    audio = {
      enable = lib.mkEnableOption "audio";
    };
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
