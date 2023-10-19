{
  emacs = ./emacs;
  gammastep = ./gammastep.nix;
  graphicalEnvironment = (import ./graphical-environment);
  terminalEnvironment = (import ./terminal-environment);
  vscode = ./vscode.nix;
}
