{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        catppuccin.catppuccin-vsc-icons
        catppuccin.catppuccin-vsc
        kamadorueda.alejandra
      ];
    };
  };

  home.packages = with pkgs; [
    alejandra
  ];
}
