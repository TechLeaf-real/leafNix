{pkgs, ...}: {
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    fishPlugins.autopair
    fishPlugins.sponge
    fzf
    eza
    xh
    zellij
    gitui
    dust
    yazi
    hyperfine
    wiki-tui
    presenterm
    fd
    sl
    cmatrix
    cowsay
    fortune
    pipes
    cbonsai
    asciiquarium
    ripgrep
    astroterm
    uutils-coreutils-noprefix
    nix-your-shell
    pokeget-rs
  ];

  programs.bash.interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
}
