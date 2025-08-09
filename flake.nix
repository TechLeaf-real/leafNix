{
  description = "Leaf Dotfiles Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    hyprland.url = "github:hyprwm/hyprland";
    pyprland.url = "github:hyprland-community/pyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
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
      url = "github:astro/deadnix?rev=e430f41ca56638b42906980e078393d2a7466b35";
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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    stable-nixpkgs,
    pyprland,
    home-manager,
    copyparty,
    disko,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      leaf-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit pyprland;

          pkgs-stable = import stable-nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/leaf-laptop/configuration.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            # home-manager.userGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.techleaf = ./hosts/leaf-laptop/home.nix;
          }
          copyparty.nixosModules.default
        ];
      };

      leaf-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit pyprland;

          pkgs-stable = import stable-nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/leaf-desktop/configuration.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            # home-manager.useGlobalPkgs = true;
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
          ./hosts/leaf-server/configuration.nix
          disko.nixosModules.disko
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
    };
  };
}
