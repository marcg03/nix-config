{
  pkgs,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "base16_transparent";
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
          auto-format = true;
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "ty"
            "ruff"
          ];
        }
        {
          name = "c";
          auto-format = true;
        }
        {
          name = "dockerfile";
          formatter = {
            command = "${pkgs.dockerfmt}/bin/dockerfmt";
          };
          auto-format = true;
        }
      ];
    };
    extraPackages = with pkgs; [
      ty
      ruff
      marksman
      typescript-language-server
      vscode-json-languageserver
      nil
      dockerfile-language-server
      yaml-language-server
      docker-compose-language-service
    ];
  };
}
