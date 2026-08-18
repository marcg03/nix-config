{ lib, config, ... }:
{
  options = {
    allowUnfreeList = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "An allow list that is used to configure nixpkgs.config.allowUnfreePredicate";
    };
  };

  config.nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) config.allowUnfreeList;
}
