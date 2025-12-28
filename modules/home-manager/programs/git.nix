{
  userConfig,
  ...
}:
{
  programs.git = {
    enable = true;

    ignores = [
      "**/.claude/settings.local.json"
      ".DS_Store"
      "*.swp"
      "*.tmp"
      "result"
    ];

    settings = {
      user.name = "${userConfig.name}";
      user.email = "${userConfig.email}";

      alias = {
        co = "checkout";
        ci = "commit";
        st = "status -sb";
        br = "branch";
        lg = "log --oneline --graph --decorate";
      };

      core.editor = "hx";
      core.autocrlf = "input";

      pull.rebase = true;
      push.default = "current";
      init.defaultBranch = "main";
      merge.ff = "only";
    };
  };
}
