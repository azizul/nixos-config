{
  description = "Ejon's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # unstable branch
    
    home-manager = {
      url = "github:nix-community/home-manager"; # master/trunk
      
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
      nixos-version = "23.11"; # FIXME defined on input; fixed to follow rolling version is 23.11
      
    in {
      # default according to working system with gdm and gde
      epictetus-default = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs;
          inherit system;
        };

        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.zizu = import ./machines/epictetus/default/home.nix;
            };
          }
          
          ./machines/epictetus/default/configuration.nix
        ];
      };

      # configured to have gdm with cinnamon and hyprland session
      epictetus = nixpkgs.lib.nixosSystem rec {
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
              users.${username} = import ./machines/epictetus/home-manager.nix;
            };
          }
          
          ./machines/epictetus/config.nix
        ];
      };
      
      
    };
  };
}
