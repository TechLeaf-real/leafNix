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
        # nur.repos.aprilthepink.suyu-mainline
      ])
      ++ (with pkgs-stable; [
        retroarch-full
        xemu
      ]);
  };
}
