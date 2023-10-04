# home-nix
The home for my NixOS and Home Manager setups.

# Structure
# Inputs
All flake inputs are only ever passed to other files through the use of an ubiquitous `flake-inputs` variable in order to make  `grep`ping through the code base easier as well as to make the provenance of data immediately obvious.
The flake's own data and functions should be passed around this way as well.

## Modules
Modules shared between NixOS or Home Manager setups are stored under `./nixosModules` and `./hmModules`.
Both contain a `default.nix` to aggregate all contained modules into an attribute set.

Modules should only be imported through `default.nix` and not by path!

Some modules are not single `nix` files but bundles, directories containing a `default.nix` and other modules.
The `default.nix` file should expose as an attribute set each sub-module as well as a module named `module` which directly imports all other modules and possibly adds misc configuration that does not warrant its own module.

## Machines
For each machine there is a top-level directory containing a `default.nix` file to define its NixOS and/or Home-Manager configurations.
Machine-specific configuration is stored in that directory.

- Nomad (Framework laptop 12th gen Intel): NixOS + Home Manager (separate)
- Tartelette (Raspberry Pi 400 used as a server): NixOS + Home Manager (using hm's NixOS module)
  An external HDD containing several partitions is attached.

## Data
The `data/` directory contains generic data for use in either NixOS or Home Manager.

# Home Manager usage
At time of writing, Home Manager is used in standalone mode for my laptop (`nomad`) and as a NixOS module on my server (`tartelette`).
I want to keep my home and system environments strictly separate in order to be able to install my home setup on non-NixOS machines.
It is however more practical to simply install NixOS with the Home Manager module baked in, and the home environment changes much less often on the server. It is also easier to upgrade since there is no need to handle Home Manager manually.
I will however keep system and home independent enough that I can use one without the other with no modifications.

# Tartelette SD Image setup
For ease of setup, I have an output `packages.aarch64-linux.tarteletteSDImage` created using `nixos-generators` which can be directly flashed onto an SD card.

However, the Raspberry Pi uses an external HDD for several partitions, including the root partition and the `/nix/store` partition.
The store partition might not contain the exact versions of packages expected by the Raspberry Pi to boot, causing a failure.
It is therefore necessary to build an image that will not try to mount the store.

Additionally, the SD card image sets a password for the user to allow for initial login.

Once the user has logged in for the first time, they can change their password, then move the store to the HDD and finally switch to the regular configuration.
