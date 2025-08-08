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
        retroarch-full
        ryubing
        cemu
        dolphin-emu
        rpcs3
        xemu
      ])
      ++ (with pkgs-stable; [
        # emulationstation-de
      ]);
  };
}
