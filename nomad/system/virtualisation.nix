{
  pkgs,
  username,
  modulesPath,
  ...
}:

{
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      # Only allows emulating host architecture, but smaller package
      package = pkgs.qemu_kvm;

      # TPM is required for Windows VMs
      swtpm.enable = true;

      ovmf = {
        enable = true;

        # Base package does not have secure boot
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  programs.dconf.enable = true;

  users.users.${username}.extraGroups = [ "libvirtd" ];

  # Mostly for virsh
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];

  # Disk image for the virtio drivers, to be used when creating a vm
  environment.systemPackages = with pkgs; [ win-virtio ];
}
