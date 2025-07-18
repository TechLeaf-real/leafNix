{ config, pkgs, pkgs-stable, ... }:

{
  imports = [
    ../../modules/home-manager/syncthing.nix
    ../../modules/home-manager/hyprland/leaf-laptop.nix
    # ../../modules/home-manager/catppuccin.nix
    ../../modules/home-manager/fish.nix
  ];

  home.username = "techleaf";
  home.homeDirectory = "/home/techleaf";

  home.stateVersion = "25.05";

  syncthing = {
    blender = false;
    code = true;
    obsidian = false;
    pictures = true;
    soundboard = true;
    videos = true;
  };

  # hyprland = {

  # };

  home.packages = with pkgs; [

  ];

  home.file = {
    
  };

  home.sessionVariables = {

  };

  programs.home-manager.enable = true;
}
