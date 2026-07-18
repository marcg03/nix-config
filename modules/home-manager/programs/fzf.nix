{ pkgs, lib, ... }:
let
  fdExcludes = [
    ".git"
    ".hg"
    ".svn"
    ".direnv"
    ".cache"
    "result"
    ".terraform"
    "node_modules"
    "dist"
    "build"
    ".next"
    ".nuxt"
    ".turbo"
    "coverage"
    "target"
    ".venv"
    "venv"
    "__pycache__"
    ".mypy_cache"
    ".pytest_cache"
    ".tox"
    ".eggs"
    "*.egg-info"
    "bin"
    "obj"
    "packages"
    ".gradle"
    "out"
    "vendor"
    "cmake-build-debug"
    "cmake-build-release"
    "CMakeFiles"
    ".ccls-cache"
    ".deps"
    ".libs"
    "autom4te.cache"
    ".bundle"
    "vendor-bin"
    ".build"
    "DerivedData"
    "*.xcworkspace"
    "*.xcodeproj"
    "_build"
    "deps"
    ".dart_tool"
    ".pub-cache"
    ".flutter-plugins"
    "dist-newstyle"
    ".stack-work"
    ".bloop"
    ".metals"
    "zig-cache"
    "zig-out"
    ".docker"
    "lost+found"
    ".Trash-*"
    ".local/share/Trash"
    "core"
    "*.core"
    ".Xauthority"
    ".dbus"
    ".gvfs"
  ];
  fdExcludeArgs = builtins.concatStringsSep " " (
    map (e: "--exclude ${lib.escapeShellArg e}") fdExcludes
  );
in
{
  home.packages = [ pkgs.fd ];
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --strip-cwd-prefix ${fdExcludeArgs}";
    fileWidget.zsh.command = "fd --type f --strip-cwd-prefix ${fdExcludeArgs}";
    changeDirWidget.zsh.command = "fd --type d --strip-cwd-prefix ${fdExcludeArgs}";
  };
}
