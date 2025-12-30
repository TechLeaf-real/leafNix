{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      nix-health
      alcom
      gimp3
      ghostty
      btop-rocm
      btop
      nautilus
      loupe
      vrc-get
      decibels
      gucharmap
      miniupnpc
      lumafly
      timg
      godot
      jq
      tree
      comma
      nix-tree
      switcheroo
      gnome-disk-utility
      alacritty
      finamp
      unrar-free
      unp
      docker-compose
    ])
    ++ (with inputs.self.packages.x86_64-linux; [
      rebuild
      update
    ])
    ++ (with pkgs-stable; [
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
