user:
{
  self,
  lib,
  config,
  ...
}:
let
  gitConfig = config.userConfig.${user}.git;
in
{
  options.userConfig.${user}.git = {
    userName = lib.mkOption {
      type = lib.types.str;
      description = "Git user name for ${user}.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Git email address for ${user}.";
    };
  };

  config.home-manager.users.${user}.imports = [
    (import "${self}/modules/home-manager/programs/git.nix" {
      userName = gitConfig.userName;
      email = gitConfig.email;
    })
  ];
}
