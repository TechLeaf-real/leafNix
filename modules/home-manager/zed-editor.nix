{pkgs, ...}: {
  programs.zed-editor = {
    enable = false;
    extraPackages = with pkgs; [
      nil
      nixd
    ];

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
    userSettings = [
      {
        use_smartcase_search = true;
        sticky_scroll.enabled = true;
        autoscroll_on_clicks = true;
        autosave.after_delay.milliseconds = 0;
        auto_update = false;
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        session.trust_all_worktrees = true;
        disable_ai = true;
        cursor_blink = true;
        icon_theme = {
          mode = "system";
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
        theme = {
          mode = "system";
          light = "Catppuccin Latte (Blur) [Heavy]";
          dark = "Catppuccin Mocha (Blur) [Heavy]";
        };
      }
    ];
  };
}
