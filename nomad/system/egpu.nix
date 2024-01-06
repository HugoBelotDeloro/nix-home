# Razer Core X Chroma eGPU enclosure
{ pkgs, username, ... }:

{
  hardware.openrazer = {
    enable = true;
    users = [ username ];
  };

  users.users.${username}.packages = [ pkgs.polychromatic ];
}
