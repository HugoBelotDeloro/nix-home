flake-inputs:

let
pkgs = flake-inputs.nixpkgs.legacyPackages.x86_64-linux;
pactl = "${pkgs.pulseaudio}/bin/pactl";
in
pkgs.writers.writeFishBin "pipewire-switch-sink" ''
set current_sink (${pactl} get-default-sink)

set next_sink (${pactl} list short sinks | ${pkgs.ripgrep}/bin/rg -v $current_sink | tail -n 1)

${pactl} set-default-sink $next_sink
''
