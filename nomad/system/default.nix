{
  config,
  pkgs,
  username,
  hostname,
  flake-inputs,
  ...
}:

{
  imports = [
    ./containers
    ./hardware-configuration.nix
    ./network.nix
    ./syncthing.nix
    ./virtualisation.nix
    ./gpu.nix
    ./iommu.nix
    ./vfio.nix
    ./egpu.nix
    flake-inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    flake-inputs.microvm.nixosModules.host
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "fr";

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  programs.light.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "Hugo Belot-Deloro";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "wireshark"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = builtins.attrValues flake-inputs.self.data.sshKeys;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.fish.enable = true;

  programs.ssh = {
    startAgent = true;
    knownHosts = flake-inputs.self.data.sshHosts;
  };

  programs.wireshark.enable = true;

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      # flags = [ "--all" "--volumes" ];
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    banner = ''
      Authorized access only! If you are not authorized to access or use this system, disconnect now!
    '';
    settings.PasswordAuthentication = false;
  };

  services.fprintd.enable = true;

  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];

  services.autorandr.enable = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services.hardware.bolt.enable = true;

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
