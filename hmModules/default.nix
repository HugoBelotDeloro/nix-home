{
  emacs = ./emacs;
  gammastep = ./gammastep.nix;
  graphicalEnvironment = (import ./graphical-environment);
  k8s = ./k8s.nix;
  minecraft = ./minecraft.nix;
  mpd = ./mpd.nix;
  terminalEnvironment = (import ./terminal-environment);
  vscode = ./vscode.nix;
}
