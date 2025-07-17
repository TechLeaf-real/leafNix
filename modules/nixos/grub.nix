{ lib, config, pkgs, ...}:

{
    boot.loader.grub = {
        theme = "${pkgs.catppuccin-grub}";
    };
}