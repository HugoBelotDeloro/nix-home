{
  config,
  lib,
  pkgs,
  ...
}:

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
    '';

    shellAliases = {

      # Eza
      ls = "eza --classify";
      la = "eza --classify --all";
      lla = "eza --classify --all --long --header";
      tree = "eza --classify --long --header --tree --git-ignore";
      treea = "eza --classify --long --header --tree --all";
    };

    shellAbbrs = {
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
      lg = "lazygit";

      # Kubectl
      k = "kubectl";
      kaf = "kubectl apply -f";
      kc = "kubectl create";
    };

    plugins = [
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
    ];
  };
}
