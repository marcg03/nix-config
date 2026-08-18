{ userName, email }: {
  programs.git = {
    enable = true;

    ignores = [
      "*.swp"
      "*.tmp"
      "result"
    ];

    settings = {
      user.name = userName;
      user.email = email;

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
