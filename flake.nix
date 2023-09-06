{
  description = "Ejon's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, ... }: {

    nixosConfigurations = let
      fullname = "Azizul Rahman Bin Azizan";
      username = "zizu";
      email = "azizul.rahman.azizan@gmail.com";
      editor = "vim";
      browser = "vieb";
      nixos-version = "23.05";
      
    in {
      # attribute lenovo-E590 machine system
      lenovoE590 = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs;
          inherit system;
          inherit username;
          inherit fullname email;
          inherit editor browser;
          inherit nixos-version;
        };

        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit username fullname email editor browser nixos-version;
              };
              users.${username} = import ./home-manager.nix;
            };
          }
          ./machines/lenovo-e590/config.nix # reload the nixos level config
        ];
      };
    };
  };
}
