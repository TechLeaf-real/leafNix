{lib, pkgs, ...}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
    ];
  };
}