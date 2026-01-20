{
  description = "NixOS with Hyprland and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Clean source to pass into Home Manager module
      src = lib.cleanSourceWith {
        src = ./.;
        filter = path: type:
          let baseName = baseNameOf path;
          in baseName != ".git" && baseName != ".direnv" && baseName != "result";
      };
    in {
      # NixOS system configuration
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
             ./hosts/laptop/configuration.nix  
          ];
        };
      };

      # Home Manager standalone configuration
      homeConfigurations = {
        cody = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit src; }; # Pass `src` to `home.nix`
          modules = [ 
            ./hosts/laptop/home.nix
          ];
        };
      };
    };
}


