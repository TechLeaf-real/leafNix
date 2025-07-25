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

    agenix = {
      url = "github:ryantm/agenix";
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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium";
  };

  outputs = {
    nixpkgs,
    stable-nixpkgs,
    pyprland,
    home-manager,
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
          inputs.agenix.nixosModules.default
          # inputs.agenix.homeManagerModules.default
          home-manager.nixosModules.home-manager
          {
            # home-manager.userGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.techleaf = ./hosts/leaf-laptop/home.nix;
          }
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
          inputs.agenix.nixosModules.default
          # inputs.agenix.homeManagerModules.default
          home-manager.nixosModules.home-manager
          {
            # home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.techleaf = ./hosts/leaf-desktop/home.nix;
          }
        ];
      };
    };
  };
}
