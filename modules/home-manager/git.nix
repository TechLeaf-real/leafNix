{...}: {
  config = {
    programs.git = {
      enable = true;
      settings.user.email = "mikiediggins@gmail.com";
      settings.user.name = "Techleaf";
    };
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
