# Templating using the mustache template engine

{ self, ... }:
let
  pkgs = self.inputs.nixpkgs.legacyPackages.x86_64-linux;
  lib = pkgs.lib;

  matchBaseName = path: builtins.match "(.+)\.mustache" (builtins.toString path);

  # Template one file using the provided data
  templatify =
    {
      path,
      data,
      name,
    }:
    let
      json = builtins.toJSON data;
    in
    pkgs.runCommand name { } ''
      echo '${json}' | ${pkgs.mustache-go}/bin/mustache ${path} > $out
    '';

  # Templates any .mustache files and leaves others unchanged
  templatifyRecursive =
    { path, data }:
    let
      directory = builtins.readDir path;
      baseName = builtins.baseNameOf path;
      fullPath =
        name:
        builtins.concatStringsSep "/" [
          path
          name
        ];
      directoryList = lib.attrsToList directory;

      processedFiles = builtins.map (
        { name, value }:
        if value == "regular" then
          let
            matches = matchBaseName name;
          in
          if matches == null then
            {
              inherit name;
              value = fullPath name;
            }
          else
            let
              newName = builtins.head matches;
              path = fullPath name;
            in
            {
              name = newName;
              value = templatify {
                inherit data path;
                name = newName;
              };
            }
        else
          {
            inherit name;
            value = templatifyRecursive {
              inherit data;
              path = fullPath name;
            };
          }
      ) directoryList;

    in
    pkgs.linkFarm baseName (builtins.listToAttrs processedFiles);

  # Necessary for flake templates, otherwise nix flake init will copy symlinks
  symlinkTreeToRegularFiles =
    path: pkgs.runCommand (builtins.baseNameOf path) { } "cp -Lr ${path} $out";

in
{
  inherit templatify templatifyRecursive symlinkTreeToRegularFiles;
}
