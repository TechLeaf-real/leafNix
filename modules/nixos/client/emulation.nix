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
      ])
      ++ (with pkgs-stable; [
        # emulationstation-de
        xemu
      ]);
  };
}
