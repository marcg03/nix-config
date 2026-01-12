{
  nhModules,
  pkgs,
  ...
}:

{
  imports = [
    "${nhModules}/common"
    "${nhModules}/programs/claude-code.nix"
    "${nhModules}/programs/codex.nix"
    "${nhModules}/programs/direnv-instant.nix"
    "${nhModules}/programs/direnv.nix"
    "${nhModules}/programs/discord.nix"
    "${nhModules}/programs/eza.nix"
    "${nhModules}/programs/foot.nix"
    "${nhModules}/programs/fzf.nix"
    "${nhModules}/programs/gaming.nix"
    "${nhModules}/programs/git.nix"
    "${nhModules}/programs/helix.nix"
    "${nhModules}/programs/jq.nix"
    "${nhModules}/programs/lazygit.nix"
    "${nhModules}/programs/misc.nix"
    "${nhModules}/programs/password-store.nix"
    "${nhModules}/programs/plasma.nix"
    "${nhModules}/programs/ripgrep.nix"
    "${nhModules}/programs/starship.nix"
    "${nhModules}/programs/tmux.nix"
    "${nhModules}/programs/top.nix"
    "${nhModules}/programs/uv.nix"
    "${nhModules}/programs/zsh.nix"
  ];

  home.packages = with pkgs; [
    monero-cli
    monero-gui
  ];

  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
