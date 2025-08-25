{pkgs, ...}: {
  options = {
  };

  config = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        nix-your-shell fish | source
      '';
      functions = {
        n = {
          body = "nix run nixpkgs#$argv";
        };
      };
      shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        cd = "z";
        cat = "bat";
        wormhole = "${pkgs.magic-wormhole-rs}/bin/wormhole-rs";
        touch = "${pkgs.bonk}/bin/bonk";
        rm = "${pkgs.gomi}/bin/gomi";
        grep = "${pkgs.ripgrep}/bin/rg";
        find = "${pkgs.fd}/bin/fd";
        nano = "${pkgs.micro}/bin/micro";
      };
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [];
    };

    programs.bat = {
      enable = true;
      config = {
        # theme = ;
        style = "numbers,changes,header";
      };
      themes = {
        catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
            sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
          };
          file = "catppuccin-mocha.tmTheme";
        };
      };
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        custom.mommy = {
          command = "${pkgs.mommy}/bin/mommy -1 -s $status";
          when = "true";
        };
        right_format = "$custom";
      };
    };

    home.file.".config/mommy/config.sh".text = ''
      MOMMY_SWEETIE="girl"
      MOMMY_COLOR="lolcat"
      MOMMY_FORBIDDEN_WORDS="fat/,"
    '';

    programs.kitty.shellIntegration.enableFishIntegration = true;
  };
}
