{ lib, pkgs, ...}:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override { plugins = with pkgs; [
      rofi-calc
      rofi-games
      rofi-file-browser
    ]; };
    theme = "custom";
    extraConfig = {
      modi = "drun,games,calc,file-browser-extended,bluetooth:rofi-bluetooth,power:rofi-power-menu,network:rofi-network-manager";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
    };
  };
  home.file.".config/rofi/themes/custom.rasi".text = ''
    * {
      rosewater: #f5e0dc;
      flamingo: #f2cdcd;
      pink: #f5c2e7;
      mauve: #cba6f7;
      red: #f38ba8;
      maroon: #eba0ac;
      peach: #fab387;
      yellow: #f9e2af;
      green: #a6e3a1;
      teal: #94e2d5;
      sky: #89dceb;
      sapphire: #74c7ec;
      blue: #89b4fa;
      lavender: #b4befe;
      text: #cdd6f4;
      subtext1: #bac2de;
      subtext0: #a6adc8;
      overlay2: #9399b2;
      overlay1: #7f849c;
      overlay0: #6c7086;
      surface2: #585b70;
      surface1: #45475a;
      surface0: #313244;
      base: #1e1e2e;
      mantle: #181825;
      crust: #11111b;
      selected-active-foreground:  @background;
      lightfg:                     @text;
      separatorcolor:              @foreground;
      urgent-foreground:           @red;
      alternate-urgent-background: @lightbg;
      lightbg:                     @mantle;
      background-color:            transparent;
      border-color:                @foreground;
      normal-background:           @background;
      selected-urgent-background:  @red;
      alternate-active-background: @lightbg;
      spacing:                     2;
      alternate-normal-foreground: @foreground;
      urgent-background:           @background;
      selected-normal-foreground:  @lightbg;
      active-foreground:           @blue;
      background:                  @base;
      selected-active-background:  @blue;
      active-background:           @background;
      selected-normal-background:  @lightfg;
      alternate-normal-background: @lightbg;
      foreground:                  @text;
      selected-urgent-foreground:  @background;
      normal-foreground:           @foreground;
      alternate-urgent-foreground: @red;
      alternate-active-foreground: @blue;
    }
    element {
        padding: 1px ;
        cursor:  pointer;
        spacing: 5px ;
        border:  0;
    }
    element normal.normal {
        background-color: @normal-background;
        text-color:       @normal-foreground;
    }
    element normal.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
    }
    element normal.active {
        background-color: @active-background;
        text-color:       @active-foreground;
    }
    element selected.normal {
        background-color: @selected-normal-background;
        text-color:       @selected-normal-foreground;
    }
    element selected.urgent {
        background-color: @selected-urgent-background;
        text-color:       @selected-urgent-foreground;
    }
    element selected.active {
        background-color: @selected-active-background;
        text-color:       @selected-active-foreground;
    }
    element alternate.normal {
        background-color: @alternate-normal-background;
        text-color:       @alternate-normal-foreground;
    }
    element alternate.urgent {
        background-color: @alternate-urgent-background;
        text-color:       @alternate-urgent-foreground;
    }
    element alternate.active {
        background-color: @alternate-active-background;
        text-color:       @alternate-active-foreground;
    }
    element-text {
        background-color: transparent;
        cursor:           inherit;
        highlight:        inherit;
        text-color:       inherit;
    }
    element-icon {
        background-color: transparent;
        size:             1.0000em ;
        cursor:           inherit;
        text-color:       inherit;
    }
    window {
        padding:          5;
        background-color: @background;
        border:           1;
    }
    mainbox {
        padding: 0;
        border:  0;
    }
    message {
        padding:      1px ;
        border-color: @separatorcolor;
        border:       2px dash 0px 0px ;
    }
    textbox {
        text-color: @foreground;
    }
    listview {
        padding:      2px 0px 0px ;
        scrollbar:    true;
        border-color: @separatorcolor;
        spacing:      2px ;
        fixed-height: 0;
        border:       2px dash 0px 0px ;
    }
    scrollbar {
        width:        4px ;
        padding:      0;
        handle-width: 8px ;
        border:       0;
        handle-color: @normal-foreground;
    }
    sidebar {
        border-color: @separatorcolor;
        border:       2px dash 0px 0px ;
    }
    button {
        cursor:     pointer;
        spacing:    0;
        text-color: @normal-foreground;
    }
    button selected {
        background-color: @selected-normal-background;
        text-color:       @selected-normal-foreground;
    }
    num-filtered-rows {
        expand:     false;
        text-color: Gray;
    }
    num-rows {
        expand:     false;
        text-color: Gray;
    }
    textbox-num-sep {
        expand:     false;
        str:        "/";
        text-color: Gray;
    }
    inputbar {
        padding:    1px ;
        spacing:    0px ;
        text-color: @normal-foreground;
        children:   [ "prompt","textbox-prompt-colon","entry","num-filtered-rows","textbox-num-sep","num-rows","case-indicator" ];
    }
    case-indicator {
        spacing:    0;
        text-color: @normal-foreground;
    }
    entry {
        text-color:        @normal-foreground;
        cursor:            text;
        spacing:           0;
        placeholder-color: Gray;
        placeholder:       "Type to filter";
    }
    prompt {
        spacing:    0;
        text-color: @normal-foreground;
    }
    textbox-prompt-colon {
        margin:     0px 0.3000em 0.0000em 0.0000em ;
        expand:     false;
        str:        ":";
        text-color: inherit;
    }
  '';
  home.file.".config/rofi/themes/games-default.rasi".text = ''
    // Colours
    * {
        background-color:               transparent;
        background:                     #1D2330;
        background-transparent:         #1D2330A0;
        text-color:                     #BBBBBB;
        text-color-selected:            #FFFFFF;
        primary:                        #BB77BB;
        important:                      #BF616A;
    }
    configuration {
        font:                           "Roboto 17";
        show-icons:                     true;
    }
    window {
        fullscreen:                     true;
        height:                         100%;
        width:                          100%;
        transparency:                   "real";
        background-color:               @background-transparent;
        border:                         0px 0px 0px 0px;
        border-color:                   @primary;
    }
    mainbox {
        children:                       [prompt, inputbar-box, listview];
        padding:                        0px 0px;
    }
    prompt {
        width:                          100%;
        margin:                         10px 0px 0px 30px;
        text-color:                     @important;
        font:                           "Roboto Bold 27";
    }
    listview {
        layout:                         vertical;
        padding:                        60px;
        dynamic:                        true;
        columns:                        7;
        spacing:                        20px;
    }
    inputbar-box {
        children:                       [dummy, inputbar, dummy];
        orientation:                    horizontal;
        expand:                         false;
    }
    inputbar {
        children:                       [textbox-prompt, entry];
        margin:                         0px;
        background-color:               @primary;
        border:                         4px;
        border-color:                   @primary;
        border-radius:                  8px;
    }
    textbox-prompt {
        text-color:                     @background;
        horizontal-align:               0.5;
        vertical-align:                 0.5;
        expand:                         false;
    }
    entry {
        expand:                         false;
        padding:                        8px;
        margin:                         -6px;
        horizontal-align:               0;
        width:                          300;
        background-color:               @background;
        border:                         6px;
        border-color:                   @primary;
        border-radius:                  8px;
        cursor:                         text;
    }
    element {
        children:                       [dummy, element-box, dummy];
        padding:                        5px;
        orientation:                    vertical;
        border:                         0px 4px solid 0px 4px;
        border-color:                   transparent;
        border-radius:                  16;
    }
    element selected {
        border-color:                   @primary;
    }
    element-box {
        children:                       [element-icon, element-text];
        orientation:                    vertical;
        expand:                         false;
        cursor:                         pointer;
    }
    element-icon {
        padding:                        10px;
        cursor:                         inherit;
        size:                           33%;
        margin:                         10px;
    }
    element-text {
        horizontal-align:               0.5;
        cursor:                         inherit;
        text-color: @text-color;
    }
    element-text selected {
        text-color: @text-color-selected;
    }
  '';
  home.file.".config/rofi/themes/games-smaller.rasi".text = ''
    @import "games-default"
    window {
        fullscreen:                     false;
        border-radius:                  10px;
        height:                         50%;
        width:                          50%;
    }
    listview {
        columns:                        5;
        padding:                        30px;
    }
    prompt {
        enabled:                        false;
    }
    inputbar {
        margin:                         20px 0px 10px 0px;
    }
    element-icon {
        padding:                        0px 10px;
        size:                           12%;
    }
  '';
  home.file.".config/rofi-games/config.toml".text = ''
  '';
}