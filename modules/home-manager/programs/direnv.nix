{ inputs, ... }:
{
  imports = [ inputs.direnv-instant.homeModules.direnv-instant ];
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    direnv-instant.enable = true;
  };
}
