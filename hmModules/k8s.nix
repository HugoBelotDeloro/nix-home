{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.k9s.enable = true;

  home.packages = with pkgs; [
    kubernetes-helm
    argocd
    k3d
    kubectl
  ];
}
