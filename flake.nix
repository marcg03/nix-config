{
  description = "A flake with NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    direnv-instant.url = "github:Mic92/direnv-instant";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "";
      inputs.home-manager.follows = "";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      flake-utils,
      nixos-hardware,
      disko,
      sops-nix,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
    in
    {
      nixosConfigurations = {
        "thinkpad-x230" = lib.nixosSystem {
          modules = [
            "${self}/modules/nixos/common.nix"
            "${self}/modules/nixos/thinkpad-x230/configuration.nix"
          ];
          specialArgs = { inherit self inputs; };
        };
        "lenovo-loq" = lib.nixosSystem {
          modules = [
            "${self}/modules/nixos/common.nix"
            "${self}/modules/nixos/lenovo-loq/configuration.nix"
          ];
          specialArgs = { inherit self inputs; };
        };
        "nixos-installer" = lib.nixosSystem {
          modules = [
            "${self}/modules/nixos/nixos-installer/configuration.nix"
          ];
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            sops
            age
            ssh-to-age
          ];
        };
      }
    );
}
