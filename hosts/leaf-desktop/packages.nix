{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages =
    (with pkgs; [
      obsidian
      haguichi
      kdePackages.kdenlive
      delfin
      xclicker
      antimatter-dimensions
      ghex
      blockbench
      legcord
      blender-hip
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
