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
        dolphin-emu
        xemu
        retroarch-full
        rpcs3
        cemu
      ])
      ++ (with pkgs-stable; [
        ]);
  };
}
