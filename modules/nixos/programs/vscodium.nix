{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.vscodium;
in {
  options = {
    vscodium = {
      enable = lib.mkEnableOption "vscodium";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alejandra
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          catppuccin.catppuccin-vsc-icons
          catppuccin.catppuccin-vsc
          kamadorueda.alejandra
          mkhl.direnv
          vadimcn.vscode-lldb
        ];
      })
    ];
  };
}
