{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      hardware,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      users = {
        "marcg" = {
          email = "marcgrec@tuta.com";
          fullName = "Marc-Alexander Grec";
          name = "marcg";
        };
      };

      mkNixosConfiguration =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            (
              { config, ... }:
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                home-manager.extraSpecialArgs = {
                  userConfig = users.${username};
                  nhModules = "${self}/modules/home-manager";
                  xkbLayout = config.services.xserver.xkb.layout;
                };
                home-manager.users.${users.${username}.name} = ./hosts/${hostname}/home/${username};
              }
            )
          ];
        };
    in
    {
      nixosConfigurations = {
        "thinkpad-x230" = mkNixosConfiguration "thinkpad-x230" "marcg";
      };
    };
}
