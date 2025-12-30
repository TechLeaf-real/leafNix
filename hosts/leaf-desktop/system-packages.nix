{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      obsidian
      nix-health
      kdePackages.kdenlive
      alcom
      parabolic
      gimp3
      ghostty
      btop-rocm
      legcord
      btop
      nautilus
      loupe
      vrc-get
      decibels
      gucharmap
      miniupnpc
      lumafly
      warp
      timg
      godot
      blender-hip
      jq
      tree
      comma
      nix-tree
      ghex
      xclicker
      antimatter-dimensions
      blockbench
      switcheroo
      gnome-disk-utility
      alacritty
      # feishin
      haguichi
      finamp
      unrar-free
      unp
      # papers
      docker-compose
      delfin
    ])
    ++ (with inputs.self.packages.x86_64-linux; [
      rebuild
      update
    ])
    ++ (with pkgs-stable; [
      aseprite
      bottles
      gnome-text-editor
      unityhub
    ])
    ++ (with inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}; [
      nix-alien
    ])
    ++ (with inputs.deadnix.packages.${pkgs.stdenv.hostPlatform.system}; [
      deadnix
    ])
    ++ (with inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}; [
      default
    ])
    ++ (with inputs.jerry.packages.${pkgs.stdenv.hostPlatform.system}; [
      default
    ]);
}
