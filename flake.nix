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
    direnv-instant.url = "github:Mic92/direnv-instant";
    systems.url = "github:nix-systems/default";
    git-hooks.url = "github:cachix/git-hooks.nix";
    helix.url = "github:marcg03/helix/patch/goto-words";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      systems,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);

      inherit (self) outputs;

      users = {
        "marcg" = {
          email = "marcgrec@tuta.com";
          fullName = "Marc-Alexander Grec";
          name = "marcg";
        };
      };

      mkNixosConfiguration =
        hostname: usernames:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              outputs
              hostname
              usernames
              ;
            userConfigs = users;
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            ./hosts/${hostname}
            { nixpkgs.overlays = [ inputs.helix.overlays.default ]; }
            home-manager.nixosModules.home-manager
            (
              { config, ... }:
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                  extraSpecialArgs = {
                    inherit inputs;
                    nhModules = "${self}/modules/home-manager";
                    xkbLayout = config.services.xserver.xkb.layout;
                  };
                  users = builtins.listToAttrs (
                    map (username: {
                      inherit (users.${username}) name;
                      value = {
                        imports = [ ./hosts/${hostname}/home/${username} ];
                        _module.args.userConfig = users.${username};
                      };
                    }) usernames
                  );
                };
              }
            )
          ];
        };
    in
    {
      nixosConfigurations = {
        "thinkpad-x230" = mkNixosConfiguration "thinkpad-x230" [
          "marcg"
        ];
        "lenovo-loq" = mkNixosConfiguration "lenovo-loq" [
          "marcg"
        ];
      };

      checks = forEachSystem (system: {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          src = ./.;
          excludes = [ "hardware-configuration\\.nix" ];
          hooks = {
            nixfmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
          };
        };
      });

      devShells = forEachSystem (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
          in
          pkgs.mkShell {
            inherit shellHook;
            buildInputs = enabledPackages;
          };
      });
    };
}
