{ pkgs, ... }:

let
  jdks = with pkgs; [ temurin-bin-8 temurin-bin-21 ];
in
{
  home.packages = with pkgs; [ prismlauncher ];

  home.file = (builtins.listToAttrs (builtins.map (jdk: {
    name = ".jdks/${jdk.version}";
    value = { source = jdk; };
  }) jdks));
}
