{
  pkgs,
  pkgs-stable,
  lib,
  config,
  ...
}: let
  cfg = config.emulation;
in {
  options = {
    emulation = {
      enable = lib.mkEnableOption "emulation";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      (with pkgs; [
        ryubing
        # emulationstation-de
        # nur.repos.aprilthepink.suyu-mainline
        dolphin-emu
        xemu
        retroarch-full
      ])
      ++ (with pkgs-stable; [
        rpcs3
        cemu
      ]);
  };
}
