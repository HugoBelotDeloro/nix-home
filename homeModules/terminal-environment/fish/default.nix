{ config, lib, pkgs, ... }:

{
  home.file.fish_functions = {
    source = ./functions;
    target = ".config/fish/functions";
    recursive = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
    set fish_greeting ""
    set CDPATH . ~/QuickAccess/
    fish_config theme choose Dracula
    bind \ce __fuzzy_find_and_open
    ${pkgs.starship}/bin/starship init fish | source
    '';

    functions = {
      __fuzzy_find_and_open = ''
      set FILENAME (fd --type f --color=always | fzf --ansi)
      if test -n "$FILENAME"
        $EDITOR $FILENAME
      end
      commandline -f repaint
      '';
    };

    shellAliases = {

      # Exa
      ls = "exa --classify";
      la = "exa --classify --all";
      lla = "exa --classify --all --long --header";
      tree = "exa --classify --long --header --tree";
      treea = "exa --classify --all --long --header --tree";
    };

    shellAbbrs = {
      vgr = "valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --leak-resolution=high";
      gccc = "gcc -Wextra -Wall -Werror -std=c99 -pedantic -g -ggdb3";
      "g+++" = "g++ -Wextra -Wall -Werror -std=c++17 -pedantic";
      clangpp = "clang++ -Wextra -Wall -Werror -std=c++17 -pedantic";
      icat = "kitty +kitten icat";

      dc = "docker compose";
      dcu = "docker compose up";
      dcd = "docker compose down";

      untargz = "tar zxvf";
      targz = "tar zcvf";
      targz-list = "tar ztvf";

      # Git
      gs = "git status";
      gss = "git status --short";
      ga = "git add";
      gap = "git add -p";
      gp = "git push";
      gpt = "git push --follow-tags";
      gf = "git fetch";
      gfp = "git fetch --prune";
      gg = "git graph";
      ggi = "git-graph-interactive";
      gcsm = "git commit -sm";
      gst = "git stash";
      gsw = "git switch";
      gswi = "git-switch-interactive";
      gcm = "git commit -m";
      gca = "git commit --amend";
      gcan = "git commit --amend --no-edit";
      gd = "git diff";
      gdc = "git diff --cached";
      gfh = "git-file-history";
      gr = "cd (git rev-parse --show-toplevel)";
      g = "git";

      # Kubectl
      k = "kubectl";
      kaf = "kubectl apply -f";
      kc = "kubectl create";
    };
  };
}
