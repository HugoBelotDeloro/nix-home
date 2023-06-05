{
  emacs = ./emacs;
  gammastep = ./gammastep.nix;
  graphicalEnvironment = (import ./graphical-environment).module;
  terminalEnvironment = (import ./terminal-environment).module;
  vscode = ./vscode.nix;
}
