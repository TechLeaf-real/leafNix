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

    nix-alien.url = "github:thiagokokada/nix-alien";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deadnix = {
      url = "github:astro/deadnix?rev=e430f41ca56638b42906980e078393d2a7466b35";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium";
  };

  outputs = {
    self,
    nixpkgs,
    stable-nixpkgs,
    pyprland,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-stable = stable-nixpkgs.legacyPackages.${system};
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
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
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
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
