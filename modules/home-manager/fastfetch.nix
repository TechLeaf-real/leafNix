{ lib, config, pkgs, ...}:

{
  home.packages = with pkgs; [
    fastfetch
  ];

  home.file = {
    "~/.config/fastfetch/config.jsonc" = {
        text = ''
          "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json", // Optional: Provides IDE intelligence
          "logo": {
            "type": "auto",
          },
          "display": {
            "brightColor": true,
          },
          "modules": [
            "title",
            "separator",
            "os",
            "host",
            "kernel",
            "uptime",
            "packages",
            "shell",
            "display",
            "de",
            "wm",
            "wmtheme",
            "theme",
            "icons",
            "font",
            "cursor",
            "terminal",
            "terminalfont",
            "cpu",
            "gpu",
            "memory",
            "swap",
            "disk",
            "localip",
            "battery",
            "poweradapter",
            "locale",
            "break",
            "colors"
          ]
        '';
      enable = true;
    };
  };
}