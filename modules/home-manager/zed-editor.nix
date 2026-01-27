{...}: {
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    mutableUserDebug = false;
    mutableUserKeymaps = false;
    mutableUserSettings = false;
    mutableUserTasks = false;
    extensions = [
      "nix"
      "catppuccin-blur-plus"
      "catppuccin-blur"
      "catppuccin"
      "catppuccin-icons"
    ];

    userDebug = [];
    userKeymaps = [];
    userTasks = [];
  };
}
