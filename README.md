# home-nix
The home for my NixOS and Home Manager setups.

# Structure
## Modules
Modules shared between NixOS or Home Manager setups are stored under `./nixosModules` and `./hmModules`.
Both contain a `default.nix` to aggregate all contained modules into an attribute set.

Modules should only be imported through `default.nix` and not by path!
Also they are imported only by `flake.nix` which passes them to the configurations as needed.

Some modules are not single `nix` files but bundles, directories containing a `default.nix` and other modules.
The `default.nix` file should expose as an attribute set each sub-module as well as a module named `module` which directly imports all other modules and possibly adds misc configuration that does not warrant its own module.

## Machines
For each machine there is a top-level directory containing a `default.nix` file to define its NixOS and/or Home-Manager configurations.
Machine-specific configuration is stored in that directory.

- Nomad (Framework laptop): NixOS + Home Manager
- Tartelette (Raspberry Pi 400 used as a server): NixOS + Home Manager

## Data
The `data/` directory contains generic data for use in either NixOS or Home Manager.
Similarly to the module directories, its contents are exported through `data/default.nix` and read by `flake.nix`, which in turn passes it to the configurations.

# Home Manager usage
At time of writing, Home Manager is used in standalone mode, even on NixOS systems.
The reason for this is that I want to keep home and system environments strictly separate in order to be able to install my home setup on non-NixOS machines.
I might however in the future switch to using Home Manager as a NixOS module for the ease of upgrade and rollback capabilities.
I will however keep both independant enough that I can use one without the other with no modifications.
