{ lib, config, pkgs, ...}:

{
    environment.systemPackages = with pkgs; [
        vscodium
        vscode-extensions.jnoortheen.nix-ide
    ];
}