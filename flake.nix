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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium";
  };

  outputs = { self, nixpkgs, stable-nixpkgs, pyprland, ... }@inputs:
  let 
    system = "x86_64-linux";
    pkgs-stable = stable-nixpkgs.legacyPackages.${system};
  in 
  {
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
        ];        
      };
    };

    packages.x86_64-linux.rebuild = 
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        packageName = "rebuild";
        packageScript = pkgs.writeShellScriptBin packageName ''
          
        '';
        packageBuildInputs = with pkgs; [];
      in pkgs.symlinkJoin {
        name = packageName;
        paths = [ packageScript ] ++ packageBuildInputs;
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = "wrapProgram $out/bin/${packageName} --prefix PATH : $out/bin";
      };
  };
}
