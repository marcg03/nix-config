{
  inputs,
  ...
}:
let
  inherit (inputs) nix-index-database;
in
{
  imports = [ nix-index-database.homeModules.default ];
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
