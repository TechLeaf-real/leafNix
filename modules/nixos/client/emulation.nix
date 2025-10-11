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
        dolphin-emu
        # emulationstation-de
        rpcs3
        # nur.repos.aprilthepink.suyu-mainline
        xemu
      ])
      ++ (with pkgs-stable; [
        retroarch-full
        cemu
      ]);
  };
}
