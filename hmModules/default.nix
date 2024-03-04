{
  emacs = ./emacs;
  gammastep = ./gammastep.nix;
  graphicalEnvironment = (import ./graphical-environment);
  k8s = ./k8s.nix;
  terminalEnvironment = (import ./terminal-environment);
  vscode = ./vscode.nix;
}
