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
