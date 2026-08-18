user:
{
  self,
  config,
  ...
}:
let
  homeConfig = config.home-manager.users.${user};
in
{
  home-manager.users.${user}.imports = [
    (import "${self}/modules/home-manager/programs/pass.nix" "${homeConfig.home.homeDirectory}/.local/share/password-store")
  ];

  environment.persistence."/data".users.${user}.directories = [
    {
      directory = ".local/share/password-store";
      mode = "0700";
    }
  ];
}
