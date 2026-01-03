{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.fish;
in {
  options = {
    fish = {
      enable = lib.mkEnableOption "fish";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      fishPlugins.autopair
      fishPlugins.sponge
      fzf
      xh
      zellij
      dust
      yazi
      hyperfine
      wiki-tui
      presenterm
      sl
      cmatrix
      cowsay
      fortune
      pipes
      cbonsai
      asciiquarium
      uutils-coreutils-noprefix
      nix-your-shell
      pokeget-rs
      blahaj
      hoard
      lolcat
    ];

    security.sudo-rs.enable = true;

    programs.starship = {
      enable = true;
      presets = ["catppuccin-powerline"];
      transientPrompt.enable = true;
    };

    programs.bash.interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
