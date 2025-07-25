{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch
  ];

  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "logo": {
        "type": "auto",
      },
      "display": {
        "seperator": ": ",
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
        "de",
        "wm",
        "wmtheme",
        "icons",
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
        "break",
        "colors"
      ]
    }
  '';
}
