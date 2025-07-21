{...}: {
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    serverProperties = {
      server-port = 25565;
      gamemode = "survival";
      motd = "NixOS!";
      max-players = 1;
    };
  };
}
