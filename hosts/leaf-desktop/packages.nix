{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages =
    (with pkgs; [
      obsidian
      haguichi
      zed-editor
      # kdePackages.kdenlive
      delfin
      xclicker
      antimatter-dimensions
      ghex
      blockbench
      legcord
      pkgsRocm.blender
      parabolic
      javaPackages.compiler.temurin-bin.jdk-25
      warp
    ])
    ++ (with pkgs-stable; [
      aseprite
      bottles
      gnome-text-editor
      unityhub
    ]);
}
