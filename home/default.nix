{
  emacs = import ./emacs;
  gammastep = import ./gammastep.nix;
  graphicalEnvironment = (import ./graphical-environment).module;
  terminalEnvironment = (import ./terminal-environment).module;
  vscode = import ./vscode.nix;
}
