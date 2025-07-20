{ lib, config, pkgs, ...}:

{
  home.packages = with pkgs; [
    fastfetch
  ];

  home.file = {
    "~/.config/fastfetch/config.jsonc".text = ''
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json", // Optional: Provides IDE intelligence
      "logo": {
        "type": "auto",
      },
      "display": {
        "brightColor": true,
      },
      "modules": [
        "title",
        // "separator",
        {
          "type": os,
          "key": "OS",
          "keyColor": "blue",
          "format": "{name} {version}"
        },
        {
          "type": "kernel",
          "key": "Kernel"
        },
        {
        "type": "memory",
        "key": "Memory",
        "percent": {
            "type": 3,
            "green": 30, 
            "yellow": 70 
        },
      ]
    '';
  };
}