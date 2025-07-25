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
      };
      shellAliases = {
        ls = "eza";
        cd = "z";
        cat = "bat";
        wormhole = "wormhole-rs";
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
    };

    # home.file.".config/starship.toml".text = ''
    #     [aws]
    #     symbol = "  "
    #     format = '\[[$symbol($profile)(\($region\))(\[$duration\])]($style)\]'

    #     [buf]
    #     symbol = " "

    #     [bun]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [c]
    #     symbol = " "
    #     format = '\[[$symbol($version(-$name))]($style)\]'

    #     [cpp]
    #     symbol = " "
    #     format = '\[[$symbol($version(-$name))]($style)\]'

    #     [cmake]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [cmd_duration]
    #     format = '\[[⏱ $duration]($style)\]'

    #     [cobol]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [conda]
    #     symbol = " "
    #     format = '\[[$symbol$environment]($style)\]'

    #     [crystal]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [daml]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [dart]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [deno]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [directory]
    #     read_only = " 󰌾"

    #     [docker_context]
    #     symbol = " "
    #     format = '\[[$symbol$context]($style)\]'

    #     [dotnet]
    #     format = '\[[$symbol($version)(🎯 $tfm)]($style)\]'

    #     [elixir]
    #     symbol = " "
    #     format = '\[[$symbol($version \(OTP $otp_version\))]($style)\]'

    #     [elm]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [erlang]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [fennel]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [fossil_branch]
    #     symbol = " "
    #     format = '\[[$symbol$branch]($style)\]'

    #     [gcloud]
    #     symbol = "  "
    #     format = '\[[$symbol$account(@$domain)(\($region\))]($style)\]'

    #     [git_branch]
    #     symbol = " "
    #     format = '\[[$symbol$branch]($style)\]'

    #     [git_status]
    #     format = '([\[$all_status$ahead_behind\]]($style))'

    #     [git_commit]
    #     tag_symbol = '  '

    #     [golang]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [gradle]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [guix_shell]
    #     symbol = " "
    #     format = '\[[$symbol]($style)\]'

    #     [haskell]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [haxe]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [helm]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [hg_branch]
    #     symbol = " "
    #     format = '\[[$symbol$branch]($style)\]'

    #     [hostname]
    #     ssh_symbol = " "

    #     [java]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [julia]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [kotlin]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [kubernetes]
    #     format = '\[[$symbol$context( \($namespace\))]($style)\]'

    #     [lua]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [memory_usage]
    #     symbol = "󰍛 "
    #     format = '\[$symbol[$ram( | $swap)]($style)\]'

    #     [meson]
    #     symbol = "󰔷 "
    #     format = '\[[$symbol$project]($style)\]'

    #     [nim]
    #     symbol = "󰆥 "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [nix_shell]
    #     symbol = " "
    #     format = '\[[$symbol$state( \($name\))]($style)\]'

    #     [nodejs]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [ocaml]
    #     symbol = " "
    #     format = '\[[$symbol($version)(\($switch_indicator$switch_name\))]($style)\]'

    #     [opa]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [openstack]
    #     format = '\[[$symbol$cloud(\($project\))]($style)\]'

    #     [os]
    #     format = '\[[$symbol]($style)\]'

    #     [os.symbols]
    #     Alpaquita = " "
    #     Alpine = " "
    #     AlmaLinux = " "
    #     Amazon = " "
    #     Android = " "
    #     Arch = " "
    #     Artix = " "
    #     CachyOS = " "
    #     CentOS = " "
    #     Debian = " "
    #     DragonFly = " "
    #     Emscripten = " "
    #     EndeavourOS = " "
    #     Fedora = " "
    #     FreeBSD = " "
    #     Garuda = "󰛓 "
    #     Gentoo = " "
    #     HardenedBSD = "󰞌 "
    #     Illumos = "󰈸 "
    #     Kali = " "
    #     Linux = " "
    #     Mabox = " "
    #     Macos = " "
    #     Manjaro = " "
    #     Mariner = " "
    #     MidnightBSD = " "
    #     Mint = " "
    #     NetBSD = " "
    #     NixOS = " "
    #     Nobara = " "
    #     OpenBSD = "󰈺 "
    #     openSUSE = " "
    #     OracleLinux = "󰌷 "
    #     Pop = " "
    #     Raspbian = " "
    #     Redhat = " "
    #     RedHatEnterprise = " "
    #     RockyLinux = " "
    #     Redox = "󰀘 "
    #     Solus = "󰠳 "
    #     SUSE = " "
    #     Ubuntu = " "
    #     Unknown = " "
    #     Void = " "
    #     Windows = "󰍲 "

    #     [package]
    #     symbol = "󰏗 "
    #     format = '\[[$symbol$version]($style)\]'

    #     [perl]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [php]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [pijul_channel]
    #     symbol = " "
    #     format = '\[[$symbol$channel]($style)\]'

    #     [pixi]
    #     symbol = "󰏗 "
    #     format = '\[[$symbol$version( $environment)]($style)\]'

    #     [pulumi]
    #     format = '\[[$symbol$stack]($style)\]'

    #     [purescript]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [python]
    #     symbol = " "

    #     [raku]
    #     format = '\[[$symbol($version-$vm_version)]($style)\]'

    #     [red]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [rlang]
    #     symbol = "󰟔 "

    #     [ruby]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [rust]
    #     symbol = "󱘗 "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [scala]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [spack]
    #     format = '\[[$symbol$environment]($style)\]'

    #     [sudo]
    #     format = '\[[as $symbol]($style)\]'

    #     [swift]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [terraform]
    #     format = '\[[$symbol$workspace]($style)\]'

    #     [time]
    #     format = '\[[$time]($style)\]'

    #     [username]
    #     format = '\[[$user]($style)\]'

    #     [vagrant]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [vlang]
    #     format = '\[[$symbol($version)]($style)\]'

    #     [zig]
    #     symbol = " "
    #     format = '\[[$symbol($version)]($style)\]'

    #     [solidity]
    #     format = '\[[$symbol($version)]($style)\]'
    # '';

    programs.kitty.shellIntegration.enableFishIntegration = true;

    home.packages = with pkgs; [
    ];
  };
}
