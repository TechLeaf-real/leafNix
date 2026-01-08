{
  description = "Leaf Dotfiles Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    hyprland.url = "github:hyprwm/hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };

    hyprshell = {
      url = "github:H3rmt/hyprshell?ref=hyprshell-release";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deadnix = {
      url = "github:astro/deadnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jerry = {
      url = "github:justchokingaround/jerry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules = {
      url = "github:numtide/nixos-facter-modules";
    };

    declarative-jellyfin = {
      url = "github:Sveske-Juice/declarative-jellyfin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jellarr.url = "github:venkyr77/jellarr";

    stardustxr-telescope = {
      url = "github:StardustXR/telescope";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    stable-nixpkgs,
    home-manager,
    copyparty,
    disko,
    declarative-jellyfin,
    nixpkgs-xr,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      leaf-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;

          pkgs-stable = import stable-nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/leaf-desktop/configuration.nix
          inputs.nur.modules.nixos.default
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nixpkgs-xr.nixosModules.nixpkgs-xr
          {
            home-manager.useUserPackages = true;
            home-manager.users.techleaf = ./hosts/leaf-desktop/home.nix;
          }
          copyparty.nixosModules.default
        ];
      };

      leaf-server = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;

          pkgs-stable = import stable-nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          inputs.stylix.nixosModules.stylix
          ./hosts/leaf-server/configuration.nix
          disko.nixosModules.disko
          declarative-jellyfin.nixosModules.default
          inputs.jellarr.nixosModules.default
          copyparty.nixosModules.default
        ];
      };
    };

    packages.x86_64-linux = {
      rebuild = let
        pkgs = import nixpkgs {system = "x86_64-linux";};

        pkg_name = "rebuild";
        src = builtins.readFile ./assets/scripts/rebuild.sh;
        script = (pkgs.writeShellScriptBin pkg_name src).overrideAttrs (old: {
          buildCommand = "${old.buildCommand}\n patchShebangs $out";
        });
        pkg_buildInputs = with pkgs; [
          nh
          git
          alejandra
          onefetch
        ];
      in
        pkgs.symlinkJoin {
          name = pkg_name;
          paths = [script] ++ pkg_buildInputs;
          buildInputs = [pkgs.makeWrapper];
          postBuild = "wrapProgram $out/bin/${pkg_name} --prefix PATH : $out/bin";
        };

      server-rebuild = let
        pkgs = import nixpkgs {system = "x86_64-linux";};

        pkg_name = "rebuild";
        src = builtins.readFile ./assets/scripts/server-rebuild.sh;
        script = (pkgs.writeShellScriptBin pkg_name src).overrideAttrs (old: {
          buildCommand = "${old.buildCommand}\n patchShebangs $out";
        });
        pkg_buildInputs = with pkgs; [
          nh
          git
        ];
      in
        pkgs.symlinkJoin {
          name = pkg_name;
          paths = [script] ++ pkg_buildInputs;
          buildInputs = [pkgs.makeWrapper];
          postBuild = "wrapProgram $out/bin/${pkg_name} --prefix PATH : $out/bin";
        };

      update = let
        pkgs = import nixpkgs {system = "x86_64-linux";};

        pkg_name = "update";
        src = builtins.readFile ./assets/scripts/update.sh;
        script = (pkgs.writeShellScriptBin pkg_name src).overrideAttrs (old: {
          buildCommand = "${old.buildCommand}\n patchShebangs $out";
        });
        pkg_buildInputs = with pkgs; [
          nh
          git
          alejandra
        ];
      in
        pkgs.symlinkJoin {
          name = pkg_name;
          paths = [script] ++ pkg_buildInputs;
          buildInputs = [pkgs.makeWrapper];
          postBuild = "wrapProgram $out/bin/${pkg_name} --prefix PATH : $out/bin";
        };

      # homesprite = let
      #   pkgs = import nixpkgs {system = "x86_64-linux";};

      #   pkg_name = "homesprite";
      #   src = fetchtar {
      #     url = "https://github.com/ismslv/HomeSprite/releases/download/1.0.0/homesprite-1.0.0.tar.gz";
      #     sha256 = "";
      #   };
      # in
    };
  };
}
