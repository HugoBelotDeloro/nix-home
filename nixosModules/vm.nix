{ flake-inputs, pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys =
      builtins.attrValues flake-inputs.self.data.sshKeys;
  };
  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    banner = "testbanner";
    settings.PasswordAuthentication = false;
  };


  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
    flake-inputs.nixos-generators.nixosModules.vm-nogui
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = {
    imports = [
      flake-inputs.self.hmModules.terminalEnvironment.module
      {
        home.stateVersion = "21.11";
      }
    ];
  };
  home-manager.extraSpecialArgs = { inherit username flake-inputs; };


  system.stateVersion = "24.05";
}
