{ pkgs, username, ...}: {
  home.packages = [ pkgs.ripgrep ];

  home.file.ripgreprc = {
    source = ./ripgreprc;
    target = ".config/ripgrep/ripgreprc";
  };

  home.sessionVariables.RIPGREP_CONFIG_PATH = "/home/${username}/.config/ripgrep/ripgreprc";
}
