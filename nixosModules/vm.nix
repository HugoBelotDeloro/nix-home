{
  flake-inputs,
  pkgs,
  username,
  ...
}:

{
  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
    flake-inputs.microvm.nixosModules.microvm
  ];

  users.users.${username} = {
    isNormalUser = true;
    password = "";
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = builtins.attrValues flake-inputs.self.data.sshKeys;
  };
  programs.fish.enable = true;

  services.getty.autologinUser = username;

  services.openssh = {
    enable = true;
    banner = "testbanner";
    settings.PasswordAuthentication = false;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [
        flake-inputs.self.hmModules.terminalEnvironment.module
        {
          home.stateVersion = "21.11";
        }
      ];
    };
    extraSpecialArgs = {
      inherit username flake-inputs;
    };
  };

  system.stateVersion = "24.05";
}
