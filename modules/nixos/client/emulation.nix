{
  pkgs,
  pkgs-stable,
  ...
}: {
  options = {
  };

  config = {
    environment.systemPackages =
      (with pkgs; [
        ryubing
        cemu
        dolphin-emu
        # emulationstation-de
        rpcs3
      ])
      ++ (with pkgs-stable; [
        retroarch-full
        xemu
      ]);
  };
}
